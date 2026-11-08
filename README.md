# DNS Connect

Android-приложение для диагностики DNS, доступности интернет-сервисов и состояния сетевого подключения.

- Android 8.0+ (API 26)
- Package: `ru.krenas.dnsanalytics`
- Текущая опубликованная версия определяется из [latest.json](https://raw.githubusercontent.com/Krenas/DNS-Connect/main/latest.json).

## Скачать

- [Последний стабильный релиз](https://github.com/Krenas/DNS-Connect/releases/latest)
- [Все версии и архивы исходников](https://github.com/Krenas/DNS-Connect/releases)
- [Манифест встроенного обновления](https://raw.githubusercontent.com/Krenas/DNS-Connect/main/latest.json)

Каждый стабильный релиз содержит:
- `DNS-Connect-VERSION-release.apk`
- `DNS-Connect-VERSION-source.zip`
- `DNS-Connect-VERSION-SHA256SUMS.txt`

Архив исходников — точный снимок кода, из которого собран соответствующий APK. В релизе проверяются имя, версия, пакет, сертификат, размер и SHA-256 APK и исходников.

## Первичная загрузка исходников 2.2.0 — один раз

1. Создайте [релиз v2.2.0](https://github.com/Krenas/DNS-Connect/releases/new?tag=v2.2.0&title=DNS%20Connect%202.2.0), заголовок `DNS Connect 2.2.0`, target `main`.
2. Прикрепите два файла с точными именами:
   - `DNS-Connect-2.2.0-release.apk`
   - `DNS-Connect-2.2.0-source.zip`
3. Опубликуйте Release.
4. Откройте [Actions → Bootstrap DNS Connect source](https://github.com/Krenas/DNS-Connect/actions/workflows/bootstrap-source.yml), нажмите **Run workflow**, ветка `main`, тег `v2.2.0`.
5. Дождитесь зелёного завершения. Workflow импортирует исходники из релиза в `main` и публикует проверенный `latest.json`.

После этого код будет постоянно храниться в GitHub. Новому чату больше не требуется получать APK или исходники через вложения.

## Продолжение в новом чате

Передайте только ссылку:

`https://github.com/Krenas/DNS-Connect`

Новый чат должен начать с [HANDOFF.md](HANDOFF.md), прочитать `README.md` и `latest.json`, затем получить архив исходников из последнего стабильного релиза. Источник истины — GitHub, а не файлы из старого чата.

## Будущие выпуски

После первичного импорта исходников новые версии собираются из `main` через [Build and publish DNS Connect](https://github.com/Krenas/DNS-Connect/actions/workflows/build-release.yml):

1. В исходниках увеличиваются `versionName` и `versionCode`.
2. Нажмите **Run workflow** на ветке `main`, укажите тег `vMAJOR.MINOR.PATCH` и текст заметок.
3. GitHub Actions запускает проверки, собирает подписанный APK, создаёт ZIP исходников и SHA256SUMS, проверяет подпись и публикует Release вместе с обновлением `latest.json`.

### Закрытая подпись

JKS не хранится в git-репозитории и не попадает в публичный архив исходников. Для сборки он загружается на временный runner из зашифрованных GitHub Actions Repository Secrets:

- `ANDROID_KEYSTORE_BASE64`
- `ANDROID_KEYSTORE_PASSWORD`
- `ANDROID_KEY_ALIAS`
- `ANDROID_KEY_PASSWORD`

Ожидаемый SHA-256 сертификата для выпусков 2.2.x: `4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90`. Секреты и их значения можно управлять только владельцу репозитория на [Settings → Secrets and variables → Actions](https://github.com/Krenas/DNS-Connect/settings/secrets/actions). Не помещайте ключ, пароль или токен в исходники, README, Release notes или обычные файлы репозитория.

## Переход с 2.1.0 на 2.2.0

Оригинальный ключ 2.1.0 не был предоставлен. 2.2.0 подписана новым ключом. Android не разрешит установить её поверх 2.1.0: сначала экспортируйте резервную копию данных, удалите 2.1.0, установите 2.2.0 и восстановите данные. Последующие версии, подписанные ключом 2.2.x, совместимы между собой.

## Ограничения проверки

Автоматические проверки не заменяют установку и тестирование на физическом Android-устройстве. До проверки на телефоне такие пункты должны отмечаться как NOT TESTED.
