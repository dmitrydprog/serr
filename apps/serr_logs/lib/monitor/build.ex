defmodule SerrLogs.Monitor.Build do
  @moduledoc false

  require Logger
  use ExActor.GenServer, export: :MonitorBuild
  alias Nostrum.Struct.Embed.Field, as: Field
  alias Nostrum.Struct.Embed, as: Embed

  defstart start_link(state) do
    initial_state(state)
  end

  defcast pool(), state: state do
    Logger.debug("Pool monitor build: #{inspect(state)}")

    state
    |> Enum.map(fn {k, %{build_services: build_services}} ->
      spawn_link(SerrLogs.Monitor.Build, :pool_domain, [self(), k, build_services])
    end)

    new_state(state)
  end

  defcast update(domain, res), state: state do
    %{
      build_channel: build_channel
    } = Map.get(state, domain)

    current_ids =
      state
      |> get_in([domain, :previous])
      |> Enum.map(fn %{id: id} -> id end)
      |> MapSet.new()

    build_ids =
      res
      |> Enum.map(fn %{id: id} -> id end)
      |> MapSet.new()

    new_build_ids = MapSet.difference(build_ids, current_ids)
    end_build_ids = MapSet.difference(current_ids, build_ids)
    new_builds = res |> Enum.filter(&MapSet.member?(new_build_ids, &1.id))

    end_builds =
      state
      |> get_in([domain, :previous])
      |> Enum.filter(&MapSet.member?(end_build_ids, &1.id))

    new_builds |> Enum.each(&create_start_msg(build_channel, &1))
    end_builds |> Enum.each(&create_end_msg(build_channel, &1))

    new_state_ = update_in(state, [domain, :previous], &(&1 ++ new_builds))

    new_state_ =
      update_in(new_state_, [domain, :previous], fn prevs ->
        prevs |> Enum.filter(&(!MapSet.member?(end_build_ids, &1.id)))
      end)

    new_state(new_state_)
  end

  @spec create_end_msg(pos_integer, map) :: :ok
  defp create_end_msg(build_channel, build) do
    Task.async(fn ->
      Nostrum.Api.create_message(
        build_channel,
        content: ":ballot_box_with_check: Сервис `#{build.name}` закончил обновление",
        embed: %Embed{
          color: 0x0000AA,
          timestamp: Timex.now(),
          fields: [
            %Field{
              name: "Текущая версия",
              value: build.from_ver
            },
            %Field{
              name: "Обновляемая версия",
              value: build.to_ver
            }
          ]
        }
      )
    end)

    :ok
  end

  @spec create_start_msg(pos_integer, map) :: :ok
  defp create_start_msg(build_channel, build) do
    Task.async(fn ->
      Nostrum.Api.create_message(
        build_channel,
        content: ":arrows_clockwise: Сервис `#{build.name}` начал обновление",
        embed: %Embed{
          color: 0x00AA00,
          timestamp: build.begin_time,
          fields: [
            %Field{
              name: "Текущая версия ",
              value: build.from_ver
            },
            %Field{
              name: " Обновляемая версия",
              value: build.to_ver
            }
          ]
        }
      )
    end)

    :ok
  end

  @spec pool_domain(pid, String.t(), list(String.t())) :: :ok
  def pool_domain(pid, domain, build_services) do
    Logger.debug("Start pool domain #{inspect(domain)}, services: #{inspect(build_services)}")

    res =
      case SerrLogs.CloudApi.get_build_status(domain) do
        result when is_list(result) ->
          Logger.debug("Pool result: #{inspect(result)}")

          result
          |> Enum.map(fn data ->
            Map.update!(data, :begin_time, &Timex.parse!(&1, "{ISO:Extended}"))
          end)
          |> Enum.filter(&(&1 != :empty))
          |> Enum.filter(&(&1.name in build_services))

        _ ->
          Logger.debug("Pool empty msg")

          :empty
      end

    unless res == :empty do
      GenServer.cast(pid, {:update, domain, res})
    end
  end
end
