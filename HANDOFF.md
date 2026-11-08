# DNS Connect — постоянный handoff и контрольная точка

## Правило каждого ответа
Любое сообщение может быть последним в чате. После каждого существенного действия обновлять этот файл и CHECKPOINT.md; сохранять новые APK/source ZIP/QA/build log/audit/release pack в Project Files проекта ChatGPT DNS; синхронизировать этот GitHub handoff, если доступен. Не просить пользователя повторно прикреплять файлы, которые уже есть в Project Files. Чётко различать локальную сборку, Project Files, GitHub commit, опубликованный Release и тест на устройстве.

## Новый чат без повторной загрузки
Создавать новый чат внутри существующего ChatGPT Project «DNS». Project Files видны чатам внутри этого проекта. Новый чат должен сам найти последние DNS-Connect-2.3.0-source.zip, DNS-Connect-2.3.0-release.apk, QA, logs, CHECKPOINT.md, а также оригинальные 2.1.0.zip, Download Zip.zip и HB_AI_Xbox_DNS.exe. Пользователь ничего не пересылает. Download Zip.zip — Android SDK/Gradle tooling archive, не app source.

## Ссылки
- Public repo: https://github.com/Krenas/DNS-Connect
- Releases: https://github.com/Krenas/DNS-Connect/releases
- Update manifest: https://raw.githubusercontent.com/Krenas/DNS-Connect/main/latest.json
- This handoff: https://github.com/Krenas/DNS-Connect/blob/main/HANDOFF.md
- Private signing store: https://github.com/Krenas/DNS-Analytics/tree/main/signing
- Confirmed prior 2.1.0 uploader run: https://github.com/Krenas/DNS-Connect/actions/runs/42395405220

## Текущий проверенный кандидат 2.3.0
- Version 2.3.0, versionCode 24, package ru.krenas.dnsanalytics, minSdk 26, targetSdk 35.
- APK SHA-256: 852c7c744b96dd5e855cdd4a039f4d092cdf00128e60dc5325e5b46f203d839d, size 459641 bytes.
- Source ZIP SHA-256: b16cc38d657ea4ce8e8690dc060070dfbac6d086f80b7e757bc52e211118068f.
- Release pack SHA-256: b9151cfc8c3a5c4b6f595acb546f53b594f9d29b007163863fc34918e1db1273.
- APK certificate SHA-256: 4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90 (preserved 2.2.x+ signer).
- Clean build from source ZIP + user SDK ZIP passed. Android SDK 35 was extracted offline; Java compile/D8/sign/zipalign passed.
- DNS/logical tests: 115 PASS / 0 FAIL. DNS catalogue: 17 PASS / 0 FAIL. Build driver regression tests: 11 PASS / 0 FAIL. UI/resources/navigation/theme/updater audit passed. Complete build log has 263 PASS lines and 0 FAIL lines (includes repeated icon/widget audits). Release package validation: 14 PASS / 0 FAIL.
- Physical Android device, real Wi-Fi/mobile DNS coverage, widget/Quick Settings runtime and live in-app update installation: NOT TESTED.
- Public v2.3.0 Release is NOT published yet. Public latest.json still points to 2.1.0; public main still lacks app/build.gradle.kts. Thus 2.3.0 is a tested local + Project Files candidate, not a live public update.

## Основные изменения 2.3.0
Home overview and primary action redesigned; tools are in a separate menu and settings in a distinct sheet. Twenty accent colours, selected-category fill, dark navigation bar, independent DNS purpose filters, separate service selection. No total selected-DNS limit; at most eight network tasks are concurrently active and results stream as checks finish. Updater verifies manifest, exact public GitHub Release URL, version, size, SHA-256, package ID and certificate before opening Android Installer. Android requires user confirmation.

## Повторяемая сборка из Project Files
Source ZIP contains four drivers:
- prepare-android-sdk.sh extracts build-tools 35 and platform 35 from the SDK archive without downloading SDK components from the network.
- build-local.sh reads versionName/versionCode/applicationId from app/build.gradle.kts; compiles, tests, creates DEX, aligns and signs.
- package-release.sh creates versioned source ZIP, latest.json, SHA256SUMS and release pack; version is dynamic.
- build-from-project-files.sh is the single entry point: validates/extracts source ZIP, prepares SDK from Download Zip.zip, compiles/signs, packages and copies outputs.

Example for an assistant runtime where Project Files are materialized:
DNS_RELEASE_KEYSTORE_PASSWORD is injected as a secure environment variable; never print/save it. The JKS remains outside source ZIP.
./build-from-project-files.sh DNS-Connect-2.3.0-source.zip 'Download Zip.zip' /secure/path/signing-key.jks /output/dns-connect

The key exists in private Krenas/DNS-Analytics/signing. It is not configured as a GitHub Actions Secret. A future cloud-only Actions build needs a secure authenticated route to the private key or an Actions secret; don't claim that is configured.

## GitHub release publisher
Public workflow: .github/workflows/publish-uploaded-release.yml. It listens for push to branch apk-upload/**. For v2.3.0, push:
- incoming/release.json
- ordered binary blobs incoming/apk/000.part, 001.part, ... (binary chunks created from Base64 API input)
- ordered binary blobs incoming/source/000.part, 001.part, ...

Important: GitHub Git Data API create_blob(encoding=base64) stores decoded binary in the repository. Therefore workflow concatenates .part files directly; it must not Base64-decode them again. Workflow validates sizes, SHA-256, package/version/versionCode, signer and source archive, imports source into main, creates the Release, attaches APK/source/SHA256SUMS, then updates latest.json. The branch transfer and actual Release are still pending. Do not claim success until public Release asset digests and latest.json are verified.

## First install and signature
2.1.0 has a different signer. To migrate: export app backup, uninstall 2.1.0, install 2.3.0, restore backup. All later releases must retain the saved 2.2.x+ key. Never create a new signing key for an update.
