# NEXT-CHAT — DNS Connect

Новый чат открывать внутри существующего Project «DNS». Сначала читать `PROJECT_STATE.json`, `CHECKPOINT.md`, этот файл и `HANDOFF.md`, затем сверять фактическое состояние GitHub Releases, `latest.json`, main и Actions. Не запрашивать повторную загрузку файлов, уже имеющихся в Project Files.

## Текущая точка — 2026-11-09
- Проект: DNS Connect.
- Репозиторий: https://github.com/Krenas/DNS-Connect
- Package ID: `ru.krenas.dnsanalytics`.
- Публичный latest пока 2.1.0 / code 22; 2.4.0 подготовлена, но ещё не опубликована.
- Кандидат: 2.4.0 / code 25; 267 PASS / 0 FAIL; APK v2/v3, zipalign и source ZIP safety PASS.
- Физический телефон в сборочной среде не подключён. Реальные device/network тесты остаются NOT TESTED.
- Project Files: `2.1.0.zip`, `Download Zip.zip`, `HB_AI_Xbox_DNS.exe`. Не просить пользователя присылать повторно.

## Updater
В Settings есть одна кнопка **«Проверить и обновить»**: fetch `latest.json` → compare version → download newer APK → verify URL/host/size/SHA-256/package/version/versionCode/signer → Android Package Installer. Пользователь подтверждает установку в Android. Не обещать silent install. Необязательная ежедневная автопроверка отправляет только уведомление.

## Подпись
Для 2.4.0 создан новый ключ, fingerprint SHA-256:
`54b847350b8f4166ea3add400330f360cbc53c4b82e53d709d2c9ff084eb21f7`.
Сохранить этот ключ без ротации для каждой будущей версии. Публичная 2.1.0 и прежний неопубликованный кандидат 2.3.0 имеют другие сертификаты; при переходе на 2.4.0 может понадобиться одна чистая переустановка, которая стирает локальные данные. Перед удалением сделать backup.

## GitHub Actions build/release
Основной workflow `.github/workflows/build-from-archive.yml`:
1. Один раз добавить repository secret `DNS_CONNECT_SIGNING_BUNDLE` на https://github.com/Krenas/DNS-Connect/settings/secrets/actions/new.
2. Значение — содержимое приватного файла `DNS-Connect-2.4.0-GitHub-Signing-Secret.txt`, переданного отдельным артефактом в текущем чате. Не коммитить файл или значение в публичный репозиторий.
3. Загрузить `DNS-Connect-2.4.0-source.zip` в https://github.com/Krenas/DNS-Connect/upload/main/incoming и нажать Commit changes.
4. GitHub Actions проверит архив, выполнит тесты, соберёт/подпишет APK на Java 17 + SDK 35, проверит пакет/версию/подпись/zipalign, опубликует Release assets и только затем обновит `latest.json`.
5. Для последующих выпусков нужен тот же единственный Actions secret; пользователю остаётся загрузить новый source ZIP и Commit.

Fallback без Actions secret: загрузить готовый pre-signed `DNS-Connect-2.4.0-release-pack.zip` в https://github.com/Krenas/DNS-Connect/upload/main/incoming/drop. Workflow `publish-release-pack.yml` проверит и опубликует готовый APK, но не пересоберёт его.

## QA и файлы
- APK 2.4.0: 1,198,136 bytes; SHA-256 `1c16821661be3c7ccee6198fbad9823563a09cc3b018cccc5aedbe11d3c33883`.
- Source ZIP: 994,643 bytes; 96 entries.
- Release pack: APK + source ZIP + QA + SHA256SUMS.
- QA: [qa/DNS-Connect-2.4.0-QA.md](qa/DNS-Connect-2.4.0-QA.md).
- Публичный Release и переход `latest.json` на 2.4.0 ещё не выполнены.
- Не выдумывать sandbox-ссылки из прошлых чатов. Файлы текущего ответа использовать только по текущим подтверждённым путям.

## Device testing
No ADB devices, Android Emulator/system image or KVM in build environment. Real install, PackageInstaller, live Wi-Fi/mobile DNS, widgets, Quick Settings and notifications are NOT TESTED.
