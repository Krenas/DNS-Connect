# DNS Connect — technical handoff

Updated: 2026-11-09. Continue the existing Android application; do not rebuild it as a new project or redesign it. Before any release claims, re-check GitHub main, releases, latest.json and Actions.

## Identity
- Public repository: https://github.com/Krenas/DNS-Connect
- Package: `ru.krenas.dnsanalytics`
- App name: DNS Connect
- Latest public release is still 2.1.0 / code 22 until a verified 2.4.0 Release is published.
- User Project Files include the 2.1.0 source archive and Android SDK package. Do not ask the user to re-upload these.

## 2.4.0 candidate
- Version: 2.4.0 / versionCode 25 / minSdk 26 / targetSdk 35.
- APK size: 1,198,136 bytes; SHA-256 `1c16821661be3c7ccee6198fbad9823563a09cc3b018cccc5aedbe11d3c33883`.
- Source ZIP size: 994,643 bytes; 96 entries.
- Release pack: APK + source ZIP + QA + SHA256SUMS.
- Signing certificate SHA-256: `54b847350b8f4166ea3add400330f360cbc53c4b82e53d709d2c9ff084eb21f7`.
- Automated regression: 267 PASS / 0 FAIL (108 self-tests, 17 catalogue checks, 142 UI/resource/navigation/theme/updater checks); 24 icon glyph types audited.
- APK Signature Scheme v2 and v3 PASS; zipalign PASS; manifest metadata PASS.
- Full QA: [qa/DNS-Connect-2.4.0-QA.md](qa/DNS-Connect-2.4.0-QA.md).

## Updater flow
Settings has one action **«Проверить и обновить»**. It reads public `latest.json`, compares version/versionCode, downloads only a newer release, verifies host/URL/size/SHA-256/package/version/signer, then hands the APK to Android Package Installer. Android confirmation is required. Optional daily auto-check only notifies; it does not silently install.

## Signing
A new 2.4.0 key was generated and preserved for future builds. Its signer SHA-256 is `54b847350b8f4166ea3add400330f360cbc53c4b82e53d709d2c9ff084eb21f7`. The public 2.1.0 and prior unpublished 2.3.0 candidate use different certificates, so a one-time uninstall/reinstall may be required. Uninstall can erase app data; back up first. All releases after 2.4.0 must use this exact key. Never expose the JKS, password or signing bundle in public files.

## GitHub Actions source build
- Workflow: `.github/workflows/build-from-archive.yml`.
- Trigger: add `incoming/DNS-Connect-*-source.zip` to main.
- The workflow validates ZIP safety, runs regression checks, builds on Java 17 + Android SDK 35, checks package/version/code/signature/zipalign, creates a GitHub Release, uploads APK/source/checksums, verifies asset digest and size, and only then updates `latest.json`.
- One Actions repository secret is required once: `DNS_CONNECT_SIGNING_BUNDLE`. It is the Base64 content of a ZIP with `release.jks` and `password.txt`; the private TXT is provided separately in the current conversation. The TXT must never be committed to the repo.
- Secret form: https://github.com/Krenas/DNS-Connect/settings/secrets/actions/new
- Source upload: https://github.com/Krenas/DNS-Connect/upload/main/incoming
- Fallback: upload the pre-signed release pack to https://github.com/Krenas/DNS-Connect/upload/main/incoming/drop; that workflow publishes but does not rebuild the APK.

## Physical device status
No phone attached; `adb devices -l` empty. No emulator binary/system image or `/dev/kvm`. Real installation, Wi-Fi/mobile DNS, widgets, Quick Settings tile, notification scheduling and Android PackageInstaller handoff are **NOT TESTED**. A local fake-resolver harness is not a live network test.

## Continuation rules
1. Re-check GitHub latest.json/release/actions before claiming publication.
2. Keep Russian UI, existing design, navigation and responsiveness.
3. Never change signer.
4. Never move latest.json before verified GitHub Release assets.
5. Separate PASS, FAIL and NOT TESTED.
6. User can click links and confirm Android prompts but cannot perform local terminal/build work.
