# DNS Connect — checkpoint 2026-11-09

## Project identity
- Public repository: https://github.com/Krenas/DNS-Connect
- Package: `ru.krenas.dnsanalytics`
- App name: DNS Connect
- Public latest manifest currently: 2.1.0 / versionCode 22. It must not be advanced until a verified GitHub Release exists.
- Persistent Project Files remain: `2.1.0.zip`, `Download Zip.zip`, `HB_AI_Xbox_DNS.exe`. Do not ask the user to upload these again.

## Current candidate — DNS Connect 2.4.0
- Version: 2.4.0 / versionCode 25 / target API 35 / min API 26.
- APK: 1,198,136 bytes; SHA-256 `d8e0e07de730161015cdfa6d9d985ed83619969bb526390c72c8bf85e12b4822`.
- Source ZIP: 995,791 bytes; SHA-256 `2ac314c55f5d553cdb62141d9e41ad109bcdca688b659710ef5ed005e361afd1`.
- Release pack: 1,952,221 bytes; SHA-256 `a2b4e5561e35212ce3a36a8cbac252b11a2a3e216f0143358060a2237f6a430f`.
- APK package/version/versionCode verified; signature v2/v3 PASS; zipalign PASS.
- Preserved private JKS signer exactly matches APK signer: `4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90`.
- Independent clean build performed from the source ZIP; all 26 APK ZIP entries match the submitted candidate byte-for-byte.
- Automated checks: **266 PASS / 0 FAIL** (108 self-tests, 17 catalogue, 141 UI/resource/navigation/theme/updater checks); separate 24-glyph audit PASS.
- Source archive: 96 entries; valid ZIP; no unsafe paths, symlinks, duplicate entries, signing files/passwords, APK/idsig or patch debris.
- Detailed QA: [qa/DNS-Connect-2.4.0-QA.md](qa/DNS-Connect-2.4.0-QA.md).

## In-app updater — one-button flow
- 2.4.0 Settings expose a single button: **«Проверить и обновить»**.
- One tap checks public `latest.json`, compares version, downloads APK, verifies exact release URL, redirect host, byte count, SHA-256, package ID, versionName, increasing versionCode and signer identity, then opens the Android Package Installer.
- Android may ask once to permit installs from DNS Connect and will ask the user to confirm the update. Silent install is not attempted or promised.
- Optional daily background auto-check remains opt-in; it only sends an update notification and does not silently install.
- An installation made from public 2.1.0 has a different certificate. That old private key is unavailable. 2.1.0 therefore needs a one-time uninstall/reinstall; this may remove local data, so back up first.
- 2.2.x/2.3.0 candidates and 2.4.0 share the retained 2.2.x signer. 2.3.0 → 2.4.0 is compatible. Keep the exact signer for all later builds; never generate a new key casually.

## Public release publication route
- Workflow: [.github/workflows/publish-release-pack.yml](.github/workflows/publish-release-pack.yml).
- Upload folder instructions: [incoming/drop/README.md](incoming/drop/README.md).
- Upload page: https://github.com/Krenas/DNS-Connect/upload/main/incoming/drop
- User action: upload exactly one file `DNS-Connect-2.4.0-release-pack.zip` and commit it to `main`.
- Workflow verifies APK/source hashes and sizes, package/version, signature v2/v3, zipalign, safe source ZIP and updater UI. It then imports the source tree, creates/updates draft Release v2.4.0, uploads APK/source/QA/checksums, verifies GitHub asset digest+size, publishes the Release and only then advances `latest.json`. The one-time pack is removed after success.
- It uses `GITHUB_TOKEN`; it does not need repository signing secrets and never uploads the private keystore or password.
- actionlint/ShellCheck passed; GitHub Actions no-pack dry-run passed:
  https://github.com/Krenas/DNS-Connect/actions/runs/42650867597
- Current actionlint/ShellCheck run after the self-describing-pack validator change: https://github.com/Krenas/DNS-Connect/actions/runs/42650678457
- The validator now derives version/package/versionCode/size/SHA-256/signer directly from the APK and source ZIP inside the pack; no extra JSON manifest is required. It verifies source archive safety before extraction.
- Full candidate release-pack validator was run locally against the actual pack and passed all APK/source/hash/signature checks.
- No public Release v2.4.0 exists yet, so `latest.json` correctly remains at 2.1.0. Do not claim in-app updates are live until pack upload and Release verification succeed.

## Device/runtime limitations
- Physical Android device is not attached: `adb devices -l` empty.
- No `/dev/kvm`, Android Emulator binary or system image in the available runtime.
- Therefore real installation, live Wi-Fi/mobile DNS, widgets, Quick Settings tile, daily background scheduling, notifications and Package Installer handoff remain **NOT TESTED**.
- A local fake-resolver test is not evidence of real ISP/mobile connectivity.

## Key files
- Latest candidate APK: `DNS-Connect-2.4.0-release.apk`.
- Latest source archive: `DNS-Connect-2.4.0-source.zip`.
- One-file release pack: `DNS-Connect-2.4.0-release-pack.zip`.
- QA: `qa/DNS-Connect-2.4.0-QA.md`.
- State: `PROJECT_STATE.json`.
- Upload workflow: `.github/workflows/publish-release-pack.yml`.
- Existing patch-2.3.0 remains historical bootstrap; once 2.4.0 is published, use the imported 2.4.0 source from main/release as the next baseline.

## Current verified workflow runs
- Publisher no-pack dry run PASS: https://github.com/Krenas/DNS-Connect/actions/runs/42638377064
- Patch repository lint/payload verification PASS: https://github.com/Krenas/DNS-Connect/actions/runs/42638341106
- Earlier 2.3 patch reconstruction PASS: https://github.com/Krenas/DNS-Connect/actions/runs/42626033799
