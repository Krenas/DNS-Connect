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

Кандидат 2.3.0 локально собран и независимо проверен: **266 PASS / 0 FAIL** (108 self-tests, 17 catalogue, 141 UI/resource/navigation/theme/updater), плюс аудит 24 типов значков. Полный локальный сценарий сборки повторён с постоянным приватным ключом; все 26 файловых записей APK, включая DEX, manifest и ресурсы, совпали с кандидатом побайтно. APK проверен через apksigner v2/v3 и zipalign.

- APK: 1,202,232 bytes; SHA-256: `6bc23aeaf3dd45f0541c1f49b74425415d204bb433272a3348a1fced37d83eb9`.
- Source ZIP: 994,948 bytes; SHA-256: `0476dbeb7d4e322007ad47c4d489ac52e730bfdb709be95f0564f336066b04ea`.
- Полный QA-отчёт: [qa/DNS-Connect-2.3.0-QA.md](qa/DNS-Connect-2.3.0-QA.md).
- Release pack: 1,961,751 bytes; SHA-256: `e5354978a4c06b91505f0cea60991a135eb7f0c5e0ffb8fa0c825047c1eaaa60`.

**Реальный Android runtime пока не проверен:** подключённого устройства нет, в окружении нет Android Emulator/system image и KVM. Live DNS на Wi-Fi/мобильной сети, установку, виджеты, Quick Settings и установщик обновлений нужно проверить на телефоне. Эти проверки не засчитываются как PASS.

Публичный Release 2.3.0 пока не опубликован, поэтому `latest.json` правильно остаётся на 2.1.0 и встроенный updater пока не предлагает 2.3.0.

**Подпись:** сохраняем постоянный ключ 2.2.x; его сертификат точно совпадает с 2.3.0 APK. Публичная 2.1.0 подписана другим сертификатом, старый закрытый ключ не найден. Поэтому 2.1.0 нельзя обновить поверх без удаления старой установки; после перехода на 2.3.0 подпись больше не менять. Удаление старой установки может удалить локальные данные.

Встроенный updater валидирует URL, версию, размер, SHA-256, package ID и сертификат APK, затем передаёт установку системному Android Installer. Android требует подтверждения установки пользователем.

## Для продолжения в новом чате

Точка входа закреплена в [`NEXT-CHAT.md`](NEXT-CHAT.md). Машиночитаемое состояние проекта хранится в [`PROJECT_STATE.json`](PROJECT_STATE.json). Новый чат должен сначала прочитать эти два файла, затем `HANDOFF.md` и `CHECKPOINT.md`, после чего продолжить работу с Project Files и реальным состоянием GitHub, не запрашивая повторную загрузку уже имеющихся файлов.
