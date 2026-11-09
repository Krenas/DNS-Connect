# DNS Connect — checkpoint 2026-11-09

## Current public state
- Repository: https://github.com/Krenas/DNS-Connect
- Package: `ru.krenas.dnsanalytics`
- Public latest is still 2.1.0 / versionCode 22. Do not advance `latest.json` until a verified Release exists.
- Candidate 2.4.0 is built and QA-checked locally; public Release 2.4.0 is NOT published.
- GitHub lint workflow passed: https://github.com/Krenas/DNS-Connect/actions/runs/42664140795

## Candidate 2.4.0
- Version: 2.4.0 / versionCode 25 / min API 26 / target API 35.
- APK size: 1,198,136 bytes.
- APK SHA-256: `1c16821661be3c7ccee6198fbad9823563a09cc3b018cccc5aedbe11d3c33883`.
- Source ZIP size: 994,643 bytes; 96 entries.
- Release pack is a single ZIP containing APK + source ZIP + QA report.
- Signing certificate SHA-256: `54b847350b8f4166ea3add400330f360cbc53c4b82e53d709d2c9ff084eb21f7`.
- APK v2/v3 signature: PASS; zipalign: PASS; package/version/versionCode: PASS.
- Tests: **267 PASS / 0 FAIL** (108 self-tests, 17 catalogue, 142 UI/resource/navigation/theme/updater); icon audit covers 24 glyph types.
- Source ZIP safety: PASS.
- QA report: [qa/DNS-Connect-2.4.0-QA.md](qa/DNS-Connect-2.4.0-QA.md).

## One-button updater
- Settings shows one button: **«Проверить и обновить»**.
- It checks GitHub latest.json, compares version, downloads newer APK, verifies URL/redirect host/size/SHA-256/package/version/versionCode/signer and opens Android Package Installer.
- Android confirmation remains mandatory.
- Optional daily auto-check is notification-only.
- Physical end-to-end updater behavior: NOT TESTED.

## Signing migration
- A new 2.4.0 release key was generated and must be preserved for all future builds.
- Fingerprint: `54b847350b8f4166ea3add400330f360cbc53c4b82e53d709d2c9ff084eb21f7`.
- Public 2.1.0 and earlier unpublished 2.3.0 candidate use different certificates. One-time uninstall/reinstall may be required; back up app data first.
- Never commit or publish JKS/password/signing bundle.

## First public 2.4.0 release — no secrets required
- Workflow: `.github/workflows/publish-release-pack.yml`.
- Upload page: https://github.com/Krenas/DNS-Connect/upload/main/incoming/drop
- User's only GitHub action: upload `DNS-Connect-2.4.0-release-pack.zip` to `incoming/drop/` and press Commit changes.
- GitHub Actions validates embedded APK/source, creates Release, uploads APK/source/QA/checksums, verifies asset digest/size, publishes the Release, advances latest.json, and removes the temporary pack.
- This publishes an already-built signed APK; it does not compile it on GitHub.
- Publisher no-pack dry-run PASS: https://github.com/Krenas/DNS-Connect/actions/runs/42652482963.
- All workflow YAML lint PASS: https://github.com/Krenas/DNS-Connect/actions/runs/42664140795.

## GitHub cloud build for later releases
- Workflow: `.github/workflows/build-from-archive.yml`.
- Trigger: commit `incoming/DNS-Connect-*-source.zip` to main.
- Runs regression checks, compiles on Java 17 + Android SDK 35, checks package/version/signature/zipalign, creates Release, uploads APK/source/checksums and only then updates latest.json.
- Requires one GitHub Actions secret: `DNS_CONNECT_SIGNING_BUNDLE` (Base64 ZIP containing release.jks and password.txt).
- This secret is NOT currently configured. Do not trigger this workflow until the secret is added under https://github.com/Krenas/DNS-Connect/settings/secrets/actions.
- No signing material is committed to the public repository.

## Device testing
- No ADB device, Android Emulator binary/system image or `/dev/kvm` in build environment.
- Real install, live Wi-Fi/mobile DNS, widgets, Quick Settings tile, notification delivery, background scheduling and PackageInstaller handoff remain **NOT TESTED**.

## First release sequence
1. Upload the release pack once to incoming/drop and commit it.
2. Wait for GitHub Actions publisher to complete successfully.
3. Verify v2.4.0 Release assets and latest.json point to the published APK.
4. Install the APK; Android will show the system confirmation.
5. Future app releases can be found through «Проверить и обновить» once published.
