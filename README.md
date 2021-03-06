# Serr

Мониторинг логов/build статусов, а так же бот для линтинга Merge Request-ов в сервисе gitlab.

## Основные возможности

### Мониторинг логов

Собирает с логов информаци по интересующим методам/сервисам, отсылает уведомления в discord чат.

![Пример работы мониторинга логов](https://lh3.googleusercontent.com/k11YQaTCLdAOauR4vgamzefA6nIv2B82_Vq17ij5-4nmt_6_5Hv2KfGTAOb2j5T9mhCWmyT0KBVqKw9f3-qebQOx0MEFHwCpNROI6KAmgzrmwEHiK0ZmZ8tIzUTwS1edyysUDtkMocTfnqUfGSnAUrUmKZc9JCHJ9NY5mJo_UPqdUguwD2JUqiPmVFwTkZ9pBgUrAbswDmjF_8zEfm0AE85ZWBp_oC4DJpfSoytAP3pbZcfOq-Mwn3vxfE6iN26CRI8amo6sc5kW0FQ7AKjvkDo4D8xuR4D9fRC_QeSEEZ6OWqtTcXk2A894N5mSZ3s7dfd6-ZzlQtJr8GbQ_CB4fTBeK6NsQIv27Ka41QlJD8pvavd6gBQGJjKbG3XxGmINLip8mFMrH6Ln3mecBIUTyd7OZlgcJRagx48i2p0fcYpVriCNhEx81_yX5eC60PeRzqm1dHgAjLQItdCuTCD8QwGh_9M8HWoHLFKf9aSWQzv6B6Nk5xD0xlfF-PeHcTBWhtf_jVUbhLSWvSrZmes2f-BnnaTpRP_BzAEIAVHEK9idSsohdkQLjiD1Tu5oxDgxFSA7bzBADXunz6Mr8DCY8BcZ6CL22sansivIvZqbYAVI15drpx94g2DfbtX2PgXpXEX1gQyjFrWbsg_o4SvtoORy=w1162-h291-no)

### Build статусы

Уведомления в чат о начале/окончание сборки сервиса.

![Пример работы build-status](https://lh3.googleusercontent.com/kald6jPIzPAHfuiRuo6VJEVNBPoH-jYML3vEwPnzRkB1pl5JMypfkf075rmTmo83Yw5IXS4cgrIPQB8Lcs3JZA-E8iZu41ruB_BhZrtzKFha0a1MbhPA-ZVim88aM4a6UuZUmX40EM1FVMx_XqrTRDA5_p18T2NW3y7Tjs9Ntp7BGDVN0YJuQT-CDsqPHQMLLvINqn6eOythCCRnUToqjmFbM-XZb0hdlS7gcV_i2oKHMrxMjU0f99d3BoweuOJPaaYHOxqejKlS6FMD5vyxPRPKaQAeBY4dO90iUCsgSYRQkiUahJIryc-ZvMClyYL2UYwlK9Rsy5H4ikPl9I96WIIhmF5p_qwtBv49mfLbYzRYf_XrAUwastllxe1_IXUZRzPjyFOsLXIUzt0pE1wc3K-pv1iwU5RFZB2sJ0TZtfQiWJppUdv4__cv2c5QiPCoRAEFohMIfI9emlKhWhdcDI7ncugjkVjaAPz7jOg5Bt-I8mt6Hnj5y_LkeB5K93mRYm77XnY_3vprv3sEVv-zH7DAbQ4YNUyFEzvzN9NMabVaZWMg_-Kx4UWfndcACxckyTBvmtALImks7UuShdJaPq9QHmZ4fgfkzm5ihDh4FG1s4L9n1ZQgw-S6nlVGWMYw1PSnF8IRr7DG1tl-NgmpgTWI=w339-h347-no)

### Линтинг MR

Предварительная проверка Merge Request-ов на несоблюдения стиля в javascript файлах.
В случае ошибок/предупреждений создается соотвествующая дискусия.

Примеры работы:
![Пример работы линтера](https://lh3.googleusercontent.com/EOp28keOut6bBAGgaBdeF2_DRwkL8Jol0YQ5UVyuuNAy0xScSZQJgELT18tlGS1O7VJbmkPvW82-yJtshdIcxXVsROv7QRdkJPLbSpl03lLgKF6dVNiVP_uMOYwe9-PejOjQlU9i0Ve6_O9HKqRS5ZjfdTTKzbQKKvSj-lI_YjYQndzqgzeuSWuN5otLKiMyvWge1yUjfP7aeIv-MhHNn6YHTGt7QaMPeL_YszntTjwGcksjTIypDd_RBsEpkoKsioRkxcOmDKP_u5hgwTzv2KP2w8LyJeCR57_QXunM2l5Dt8r4mQqsaJlPfNuLALsIlVX3Igjj78WQ9PmJrFaHSJ3jcBdPk6Pt43QG7jluz4wwK43iwXa2JJJ6JL41J9ZOS59oDyct0WFloq3bY8lCR4x_iRnl9bP7vvYpPA5_KMdHMTMJrYp4wSFtsZx02hIYYDm0pqbEyqXIMh4C0rbu0yWF_doWLHNI70A9l9yFmyiLEzKZ_tUdFg0NLoScErTsnjLZrEpZui4ql1IEFNJa57RFtEwf35NjPyBkaxUzn0yWcaK1oE14KccP-YLlZuKL4lml-gaytdpLiTEpDtdRbRAz3RRriHJp6EiX1D9lhV6zW4X5xgNM4lyiEJEnE96RF-fTEVZGX1SR7RunhO2au0LB4L_TXWzCi6rgqLsKo6G5J2aQia52ZrEIVECoVRmkCIvkKjidxYy3DaWhMQ=w1280-h378-no)
