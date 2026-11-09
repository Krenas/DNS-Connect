# DNS Connect — checkpoint 2026-11-09

## Current public state
- Repository: https://github.com/Krenas/DNS-Connect
- Package: `ru.krenas.dnsanalytics`
- Public latest: 2.1.0 / versionCode 22. Keep `latest.json` unchanged until a verified Release exists.
- Candidate 2.4.0 is built locally and QA-checked; public Release 2.4.0 is NOT published.

## Candidate 2.4.0
- Version: 2.4.0 / versionCode 25 / min API 26 / target API 35.
- APK size: 1,198,136 bytes.
- APK SHA-256: `1c16821661be3c7ccee6198fbad9823563a09cc3b018cccc5aedbe11d3c33883`.
- Source ZIP size: 994,643 bytes; 96 entries.
- Release pack contains APK + source ZIP + QA + SHA256SUMS.
- Signing certificate SHA-256: `54b847350b8f4166ea3add400330f360cbc53c4b82e53d709d2c9ff084eb21f7`.
- APK Signature Scheme v2/v3: PASS; zipalign: PASS; package/version/versionCode: PASS.
- Regression tests: 108 PASS / 0 FAIL.
- Catalogue tests: 17 PASS / 0 FAIL.
- UI/navigation/theme/resources/updater checks: 142 PASS / 0 FAIL.
- Combined: **267 PASS / 0 FAIL**. Icon audit: 24 glyph types PASS.
- Source archive: no duplicate/unsafe paths, symlinks, credentials, APKs or patch debris.
- QA report: [qa/DNS-Connect-2.4.0-QA.md](qa/DNS-Connect-2.4.0-QA.md).

## One-button updater
- Settings shows one button: **«Проверить и обновить»**.
- It checks GitHub latest.json, compares version, downloads only newer APK, verifies URL/redirect host/size/SHA-256/package/version/signer and opens Android Package Installer.
- Android confirmation remains mandatory.
- Optional daily auto-check is notification-only.
- Physical end-to-end updater behavior: NOT TESTED.

## Signing migration
- A new release key was created for 2.4.0 because the previous release key could not be used from this build environment.
- Keep this exact signer for every later version: `54b847350b8f4166ea3add400330f360cbc53c4b82e53d709d2c9ff084eb21f7`.
- Public 2.1.0 and previous unpublished 2.3.0 candidate use different signers. One-time uninstall/reinstall may be required; back up app data first. After 2.4.0 is installed, future releases with this signer can update in place.
- Never commit or publish JKS/password/signing bundle.

## GitHub cloud build
- Main workflow: `.github/workflows/build-from-archive.yml`.
- Trigger: commit `incoming/DNS-Connect-*-source.zip` to main.
- It runs regression checks, builds with Java 17 + Android SDK 35, checks the signer, package, version and zipalign, creates a Release, uploads APK/source/checksums, verifies assets, then updates `latest.json`.
- One repository secret is required once: `DNS_CONNECT_SIGNING_BUNDLE` (Base64 ZIP containing `release.jks` and `password.txt`).
- The corresponding private secret text file is provided as a separate artifact in the current conversation. It must only be pasted into GitHub Actions Secrets and must never be committed.
- New-secret page: https://github.com/Krenas/DNS-Connect/settings/secrets/actions/new
- Source upload page: https://github.com/Krenas/DNS-Connect/upload/main/incoming
- Fallback without secret: upload pre-signed release pack to https://github.com/Krenas/DNS-Connect/upload/main/incoming/drop; `publish-release-pack.yml` validates and publishes but does not rebuild the APK.

## Device testing
- ADB device list empty; no emulator binary/system image or `/dev/kvm`.
- Real installation, live Wi-Fi/mobile DNS, widgets, Quick Settings tile, notification delivery, background scheduling and PackageInstaller handoff remain **NOT TESTED**.
- Never report physical-device tests as PASS.

## Required publication sequence
1. User adds `DNS_CONNECT_SIGNING_BUNDLE` once (value from separate private TXT artifact).
2. User uploads `DNS-Connect-2.4.0-source.zip` to `incoming/` and commits.
3. GitHub Actions builds, signs, publishes v2.4.0 and updates latest.json.
4. User installs APK from Release. From then on, future verified releases can be installed from the app's single update button.
