# NEXT-CHAT — DNS Connect

Новый чат открывать внутри существующего Project «DNS». Сначала читать `PROJECT_STATE.json`, `CHECKPOINT.md`, этот файл и `HANDOFF.md`, затем сверять фактическое состояние GitHub Releases, `latest.json`, main и Actions. Не запрашивать повторную загрузку Project Files.

## Текущая точка
- Проект DNS Connect; repo https://github.com/Krenas/DNS-Connect.
- Package ID `ru.krenas.dnsanalytics`.
- Public latest пока 2.1.0 / code 22; Release 2.4.0 ещё не опубликован.
- Подготовлен кандидат 2.4.0 / code 25, тесты 267 PASS / 0 FAIL, APK v2/v3 + zipalign PASS.
- В Project Files уже есть `2.1.0.zip`, `Download Zip.zip`, `HB_AI_Xbox_DNS.exe`. Не просить повторно.

## Updater
Settings содержит одну кнопку **«Проверить и обновить»**: fetch latest.json → compare version → download newer APK → verify URL/host/size/SHA-256/package/version/versionCode/signer → Android Package Installer. Пользователь подтверждает установку в Android. Ежедневная проверка — только уведомление, без тихой установки.

## 2.4.0 подпись
Для 2.4.0 создан новый signing key. SHA-256 сертификата:
`54b847350b8f4166ea3add400330f360cbc53c4b82e53d709d2c9ff084eb21f7`.
Сохранять этот ключ для каждой будущей версии. Публичная 2.1.0 и прежний неопубликованный 2.3.0 имеют другой сертификат; может понадобиться однократное удаление старой установки и повторная установка. Удаление может стереть локальные данные — backup first.

## Первая публикация 2.4.0
- Download the release pack from the current chat: `DNS-Connect-2.4.0-release-pack.zip`.
- Open https://github.com/Krenas/DNS-Connect/upload/main/incoming/drop.
- Upload exactly that ZIP and press Commit changes.
- `.github/workflows/publish-release-pack.yml` verifies APK/source, creates Release, uploads APK/source/QA/checksums, verifies GitHub asset SHA-256/size and then advances latest.json. No signing secret is required.
- After success, direct APK appears in GitHub Releases and the app can find the update.
- Public latest remains 2.1.0 until this actually completes.

## GitHub cloud build
`.github/workflows/build-from-archive.yml` is configured to build source ZIP on Java 17 + Android SDK 35 and publish the signed release. It requires the one protected secret `DNS_CONNECT_SIGNING_BUNDLE` (Base64 ZIP of JKS + password). That secret is not configured yet, so do not run this workflow until configured. Secret settings: https://github.com/Krenas/DNS-Connect/settings/secrets/actions.

## QA/device status
- 267 automated checks PASS / 0 FAIL.
- Real Android device unavailable: physical install, live Wi-Fi/mobile DNS, widgets, Quick Settings, notifications and PackageInstaller handoff are NOT TESTED.
- Latest GitHub workflow lint passed: https://github.com/Krenas/DNS-Connect/actions/runs/42664140795.
