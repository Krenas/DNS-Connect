# DNS Connect — технический handoff

Обновлено: 2026-11-09. Продолжать существующее Android-приложение, не начинать новый проект. Перед любыми изменениями сверить фактические GitHub Releases, latest.json, main и Actions. Не полагаться на устаревшие локальные пути.

## Проект

- Публичный репозиторий: https://github.com/Krenas/DNS-Connect
- Package ID: `ru.krenas.dnsanalytics`
- Название: DNS Connect
- Последний опубликованный релиз: 2.1.0 / versionCode 22.
- Текущий локально собранный и QA-проверенный кандидат: 2.4.0 / versionCode 25.
- Project Files уже есть в текущем Project DNS: `2.1.0.zip`, `Download Zip.zip`, `HB_AI_Xbox_DNS.exe`. Не просить пользователя загружать их повторно.
- Сохранять текущую идентичность интерфейса и логотип с тремя серверами; русская локализация, плавные переходы, отсутствие мелкого/налезающего текста, рабочие экраны и быстрые неблокирующие проверки — приоритеты пользователя.

## 2.4.0 — текущий кандидат

- APK: 1,198,136 bytes; SHA-256 `d8e0e07de730161015cdfa6d9d985ed83619969bb526390c72c8bf85e12b4822`.
- Source ZIP: 995,791 bytes; SHA-256 `2ac314c55f5d553cdb62141d9e41ad109bcdca688b659710ef5ed005e361afd1`.
- Release pack: 1,952,221 bytes; SHA-256 `a2b4e5561e35212ce3a36a8cbac252b11a2a3e216f0143358060a2237f6a430f`.
- QA: 266 PASS / 0 FAIL (108 JVM self-tests, 17 DNS catalogue tests, 141 UI/resource/navigation/theme/updater checks); 24 icon glyph types audit PASS.
- Package/version/versionCode checked; APK Signature Scheme v2/v3 PASS; zipalign PASS.
- Source ZIP: 96 entries, integrity and safety PASS; no unsafe paths, symlinks, duplicate entries, keystore/passwords, APK/idsig or patch debris.
- Independent clean source build: all 26 APK ZIP entry contents, including DEX, manifest and resources, matched the candidate byte-for-byte.
- Full QA: [qa/DNS-Connect-2.4.0-QA.md](qa/DNS-Connect-2.4.0-QA.md).
- Build files must be re-verified by hash before next use; never invent sandbox paths in later chats.

## Обновления внутри приложения

Settings → Updates has a single action **«Проверить и обновить»**. It fetches `latest.json`, compares version/versionCode, downloads the release APK, verifies GitHub URL/redirect host, byte size, SHA-256, package ID, versionName, increasing versionCode and signer certificate, then passes the verified APK to Android Package Installer.

- User confirms the system installation prompt. Android may ask once to allow app installs from DNS Connect. No silent install bypass.
- Optional daily auto-check is notification-only; it does not install or download silently.
- After 2.4.0 is installed and its release is published, later updates can be initiated in-app by the one button; only Android's confirmation remains.
- The updater must not advertise a candidate that is absent from a public verified Release.

## Подпись и совместимость

Keep the private DNS Connect 2.2.x JKS. It matches the 2.4.0 APK signer exactly:
`4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90`.

Public 2.1.0 uses another signer:
`7767de2ba22670531c53ca6c76ea74e82c4d140f0907727644b2cd0864840c2b`.
Its old private key was not found. No genuine Android signing-rotation lineage can be made without that old key. Therefore:
- 2.1.0 → 2.4.0 requires one-time uninstall/reinstall and can erase app-local data; advise backup first.
- 2.2.x/2.3.x/2.4.0 using retained signer are compatible for in-place updates.
- Do not generate a new key or rotate signer in future versions.
- Never expose JKS, password or Base64 signing material in public repo or ZIP.

## Первая публикация 2.4.0 — один раз

Public `latest.json` remains at 2.1.0. Release `v2.4.0` does not exist yet. Do not change latest.json until real Release assets exist and their SHA-256/size match.

Active workflow: [publish-release-pack.yml](.github/workflows/publish-release-pack.yml).

Upload folder: [incoming/drop](incoming/drop/README.md)

One-time upload page:
https://github.com/Krenas/DNS-Connect/upload/main/incoming/drop

The owner downloads the release-pack ZIP from the current conversation artifact link, uploads exactly one file named `DNS-Connect-2.4.0-release-pack.zip` to that folder and commits it to main.

The workflow then autonomously:
1. Finds exactly one release pack and checks ZIP integrity.
2. Extracts exactly one APK, source ZIP and QA report.
3. Derives version, package, versionCode, APK/source size and SHA-256 from the actual files; sidecar JSON manifest is not required.
4. Verifies APK package/version/versionCode, fixed signer, v2/v3 signatures and zipalign.
5. Validates source ZIP paths/symlinks/duplicates/secrets and checks updater entry point.
6. Imports the verified Gradle source tree into main.
7. Creates/updates draft GitHub Release and uploads APK/source/QA/checksums.
8. Reads GitHub Release assets and verifies exact digest and byte size.
9. Publishes Release and only then writes the new latest.json.
10. Removes the temporary upload pack after success.

This pre-signed publication route does not require repository signing secrets. The signing key remains private. User does not build locally or edit code.

GitHub proof:
- Publisher no-pack dry-run PASS: https://github.com/Krenas/DNS-Connect/actions/runs/42650867597
- actionlint/ShellCheck and patch repo checks PASS: https://github.com/Krenas/DNS-Connect/actions/runs/42650678457

These are static/no-pack dry runs only. Actual upload, Release creation and latest.json publish have NOT run because the pack is not committed yet. Do not say update discovery is live until it has.

## Проверки на реальном устройстве

No physical device is attached to this runtime; ADB device list empty, no KVM or Android Emulator/system image. Consequently the following remain NOT TESTED:
- First install / in-place update / Android Package Installer.
- Live Wi-Fi/mobile DNS probes and real ISP reachability.
- Launcher widget add/resize/refresh/tap.
- Quick Settings tile.
- Daily WorkManager/notification behavior under Android power management.
- In-app download from a public Release.

Do not claim physical tests PASS. The user will perform them after initial install.

## Правила продолжения

1. Re-read this file, NEXT-CHAT.md, CHECKPOINT.md and PROJECT_STATE.json.
2. Check live repository/releases/latest.json/Actions.
3. Keep app Russian-first and continue the existing project; do not redesign it.
4. Preserve 2.2.x signer.
5. Do not change latest.json before verified Release assets.
6. Keep PASS/FAIL/NOT TESTED evidence separate.
7. Avoid asking user to perform code or local terminal work. The only expected user actions are the one-time pack upload/commit and installation confirmation; routine later updates happen through «Проверить и обновить».
