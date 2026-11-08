# DNS Connect — per-turn checkpoint

Последняя проверка: 2026-11-08, clean build-from-Project-Files pipeline.

## Кандидат 2.3.0
- versionCode 24; package ru.krenas.dnsanalytics; minSdk 26; targetSdk 35.
- APK SHA-256: 852c7c744b96dd5e855cdd4a039f4d092cdf00128e60dc5325e5b46f203d839d (459641 bytes).
- Source ZIP SHA-256: b16cc38d657ea4ce8e8690dc060070dfbac6d086f80b7e757bc52e211118068f.
- Release pack SHA-256: b9151cfc8c3a5c4b6f595acb546f53b594f9d29b007163863fc34918e1db1273.
- APK signer fingerprint: 4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90.

## Последние проверки
- Clean build from source ZIP + Download Zip.zip: PASS (offline SDK prep, Java compile, D8, signing, zipalign, package).
- DNS/logical self-tests: 115 PASS / 0 FAIL.
- Catalogue: 17 PASS / 0 FAIL.
- Build drivers: 11 PASS / 0 FAIL.
- UI/resource/navigation/theme/updater audit: PASS; integrated log 263 PASS lines / 0 FAIL lines.
- Release package integrity: 14 PASS / 0 FAIL.
- APK v2/v3 signature and package/version identity: PASS.
- Real handset, user network, widget/Quick Settings runtime and in-app installer: NOT TESTED.

## GitHub status (recheck before each claim)
- Release v2.3.0: NOT PUBLISHED.
- latest.json: still 2.1.0.
- Public main Android source: NOT IMPORTED.
- Publisher workflow exists and expects binary .part chunks in branch apk-upload/v2.3.0.

## Continuity
Every new chat must be created inside the same ChatGPT Project DNS. Retrieve latest APK/source/log/QA/handoff from Project Files. The user must not re-upload originals. Every substantial assistant response updates this checkpoint, HANDOFF.md and the Project Files latest artifacts.

## Next action
Transfer the verified APK/source through the binary-chunk publisher workflow. Verify Release asset digests and latest.json, then verify app sources imported into public main. Only then test live update detection/download/install on a real Android device.
