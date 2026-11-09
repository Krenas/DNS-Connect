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

Пользователю не нужно самостоятельно собирать APK. Когда исходный ZIP попадает в `incoming/` и настроены два signing secrets, workflow выполняет сборку, проверки и публикацию. В текущей среде GitHub-коннектор позволяет менять исходный код и workflow, но не предоставляет операции загрузки бинарных Release assets или записи repository Actions secrets; поэтому публикация текущего локального кандидата ещё не выполнена.

## Продолжение без повторной загрузки файлов

Создавайте новый чат внутри существующего ChatGPT Project DNS. Project Files проекта уже содержат исходную базу 2.1.0.zip, отдельный `DNS-Connect-2.1.0-source.zip`, компоненты Android SDK и `HB_AI_Xbox_DNS.exe`. Новый чат должен прочитать HANDOFF.md и CHECKPOINT.md, затем использовать постоянный патч из `bootstrap/patch-2.3.0/`. Повторно загружать эти файлы не нужно.

## Постоянный патч 2.3.0

Публичный `bootstrap/patch-2.3.0/` содержит 13 проверенных фрагментов, manifest и инструкции. Строгая проверка GitHub Actions сверяет каждый chunk, полный Base64, gzip и unified diff с SHA-256 в manifest.

## Статус публикации

Кандидат 2.3.0 теперь локально собран и проверен: 266 automated PASS / 0 FAIL; apksigner v2/v3 и zipalign — PASS. APK SHA-256: `b376f8f15e6bcf815845bdb65bb6cd204703a5f9d21282b63a658f86d1407ff4`. Source ZIP SHA-256: `6a2f58e6dda10a94963992c2ede9a2976a07c1d0a59e9a08b2873809b827ba0a`. Подробности и размеры — в `CHECKPOINT.md`. Публичный Release 2.3.0 пока не опубликован, поэтому `latest.json` правильно остаётся на 2.1.0 и кнопка обновления пока не предложит новую версию. Кроме того, 2.3.0 подписан сохранённым ключом 2.2.x; его сертификат отличается от публичного APK 2.1.0, поэтому обновление поверх 2.1.0 не поддерживается без миграции/переустановки.

Встроенный updater валидирует URL, версию, размер, SHA-256, package ID и сертификат APK, затем передаёт установку системному Android Installer. Android требует подтверждения установки пользователем.


## Для продолжения в новом чате

Точка входа закреплена в [`NEXT-CHAT.md`](NEXT-CHAT.md). Машиночитаемое состояние проекта хранится в [`PROJECT_STATE.json`](PROJECT_STATE.json). Новый чат должен сначала прочитать эти два файла, затем `HANDOFF.md` и `CHECKPOINT.md`, после чего продолжить работу с Project Files и реальным состоянием GitHub, не запрашивая повторную загрузку уже имеющихся файлов.
