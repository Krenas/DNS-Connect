# DNS Connect

> **Продолжение проекта:** новый чат внутри Project «DNS» должен начинать с [NEXT-CHAT.md](NEXT-CHAT.md), затем сверять [HANDOFF.md](HANDOFF.md) и [CHECKPOINT.md](CHECKPOINT.md). Повторная загрузка уже существующих Project Files не требуется.

Android-приложение для диагностики DNS-резолверов, интернет-подключения и выбранных сервисов.

- Package: `ru.krenas.dnsanalytics`
- Android 8.0+ (API 26)
- Публичный репозиторий: https://github.com/Krenas/DNS-Connect
- Постоянная инструкция: [HANDOFF.md](HANDOFF.md)
- Контрольная точка: [CHECKPOINT.md](CHECKPOINT.md)

## Скачать
- Последний опубликованный релиз: https://github.com/Krenas/DNS-Connect/releases/latest
- Все релизы: https://github.com/Krenas/DNS-Connect/releases
- Манифест встроенного обновления: https://raw.githubusercontent.com/Krenas/DNS-Connect/main/latest.json

## Автоматическая сборка из ZIP

Сборка устроена по схеме «архив исходников → папка incoming → GitHub Actions → APK → GitHub Release → latest.json».

1. Поместить архив с чистым Gradle-проектом в `incoming/DNS-Connect-MAJOR.MINOR.PATCH-source.zip`.
2. Commit/push ZIP в `main`. Workflow `.github/workflows/build-from-archive.yml` запустится автоматически.
3. GitHub Actions проверит структуру ZIP и отсутствие ключей подписи, установит Java 17 и Android SDK 35, запустит тесты и соберёт APK.
4. Workflow проверит пакет, версию, сертификат подписи и zipalign; создаст Release, загрузит APK/source ZIP/checksums и сверит размер/SHA-256.
5. После публикации обновится `latest.json`. DNS Connect сможет найти новую версию через кнопку проверки обновлений.
6. После успешной публикации временный ZIP будет удалён из `incoming`.

Ручной запуск тоже доступен в [GitHub Actions](https://github.com/Krenas/DNS-Connect/actions/workflows/build-from-archive.yml).

### Однократная настройка подписи

Перед первым build workflow владелец репозитория должен добавить в [Settings → Secrets and variables → Actions](https://github.com/Krenas/DNS-Connect/settings/secrets/actions) два защищённых repository secrets:

- `ANDROID_KEYSTORE_BASE64` — Base64 сохранённого JKS из приватного репозитория.
- `ANDROID_KEYSTORE_PASSWORD` — пароль JKS.

Alias `dnsconnect` зафиксирован в workflow; для ключа используется тот же пароль, что и для хранилища. Значения нельзя помещать в публичный репозиторий, исходный ZIP, коммиты или логи. Workflow остановится, если один из двух secrets отсутствует или сертификат не совпадает с сохранённым signer.

**Пользователю не нужно собирать APK или вручную загружать архив в GitHub.** Эту операцию выполняет помощник, коммитя ZIP в указанную папку проекта. После этого APK собирается и публикуется на GitHub.

## Продолжение без повторной загрузки файлов

Создавайте новый чат внутри существующего ChatGPT Project DNS. Project Files проекта уже содержат исходную базу 2.1.0.zip, отдельный `DNS-Connect-2.1.0-source.zip`, компоненты Android SDK и `HB_AI_Xbox_DNS.exe`. Новый чат должен прочитать HANDOFF.md и CHECKPOINT.md, затем использовать постоянный патч из `bootstrap/patch-2.3.0/`. Повторно загружать эти файлы не нужно.

## Постоянный патч 2.3.0

Публичный `bootstrap/patch-2.3.0/` содержит 13 проверенных фрагментов, manifest и инструкции. Строгая проверка GitHub Actions сверяет каждый chunk, полный Base64, gzip и unified diff с SHA-256 в manifest.

## Статус публикации

Кандидат 2.3.0 локально собирался и прошёл автоматические проверки в предыдущем runtime, а его постоянный patch независимо проверен GitHub Actions. Однако публичный Release 2.3.0 пока не опубликован: `latest.json` на данный момент указывает на 2.1.0. Не сообщайте, что кнопка обновления уже предлагает 2.3.0, пока новый Release и публичный manifest не будут проверены.

Встроенный updater валидирует URL, версию, размер, SHA-256, package ID и сертификат APK, затем передаёт установку системному Android Installer. Android требует подтверждения установки пользователем.
