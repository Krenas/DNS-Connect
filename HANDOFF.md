# DNS Connect — technical handoff

Updated: 2026-11-09. Continue the existing Android application; do not rebuild as a new project or redesign. Before release claims, re-check GitHub main, releases, latest.json and Actions.

## Identity
- Public repository: https://github.com/Krenas/DNS-Connect
- Package: `ru.krenas.dnsanalytics`
- App name: DNS Connect
- Public latest is currently 2.1.0 until a verified v2.4.0 Release exists.
- Project Files already contain the 2.1.0 base archive and supporting files. Do not ask the user to re-upload them.

## 2.4.0 candidate
- Version 2.4.0 / versionCode 25 / minSdk 26 / targetSdk 35.
- APK size 1,198,136 bytes; SHA-256 `1c16821661be3c7ccee6198fbad9823563a09cc3b018cccc5aedbe11d3c33883`.
- Source ZIP 994,643 bytes; 96 entries.
- One-file release pack contains APK, source ZIP and QA report.
- Signing certificate SHA-256 `54b847350b8f4166ea3add400330f360cbc53c4b82e53d709d2c9ff084eb21f7`.
- Automated checks 267 PASS / 0 FAIL; APK v2/v3 and zipalign PASS.
- QA: [qa/DNS-Connect-2.4.0-QA.md](qa/DNS-Connect-2.4.0-QA.md).

## Updater
Settings has one action **«Проверить и обновить»**. It checks GitHub latest.json, compares version/versionCode, downloads only a newer release, verifies host/URL/size/SHA-256/package/version/signer, then opens Android Package Installer. Android confirmation required. Optional daily check only notifies and does not silently install.

## Signing
A new 2.4.0 key was generated. Preserve the exact signer SHA-256 `54b847350b8f4166ea3add400330f360cbc53c4b82e53d709d2c9ff084eb21f7` for every future release. Public 2.1.0 and previous unpublished 2.3.0 candidate use different certificates, so one-time uninstall/reinstall may be needed. Uninstall can erase local data; back up first. Never expose JKS/password/signing bundle in public files.

## First release — pre-signed package
- Workflow: `.github/workflows/publish-release-pack.yml`.
- Upload page: https://github.com/Krenas/DNS-Connect/upload/main/incoming/drop
- Upload `DNS-Connect-2.4.0-release-pack.zip` and commit to main.
- GitHub Actions verifies APK/signature/zipalign/source safety, creates a Release, uploads APK/source/QA/checksums, verifies asset digests/sizes, and only then updates latest.json.
- No repository secret is needed. This publishes the already-compiled APK; it does not rebuild it.
- The 2.4.0 public Release is not published yet; latest.json must remain at 2.1.0 until this workflow completes.

## GitHub automatic compilation workflow
- `.github/workflows/build-release.yml` now triggers on versioned source/build changes pushed to `main`; it derives the version from `app/build.gradle.kts`, uses `CHANGELOG.md`, runs checks, builds/signs APK, validates Release assets, then updates `latest.json`.
- The initial source-import commit is intentionally excluded from this trigger so the initial 2.4.0 release-pack publication cannot race a second publication of the same tag.
- For future releases after import, no manual workflow dispatch and no per-version source ZIP upload are needed.
- One-time signing secret required: `DNS_CONNECT_SIGNING_BUNDLE` (Base64 ZIP containing the exact 2.4.0 JKS and password). Secret is not configured; never publish the key.
- Initial source import remains a one-time upload of the prebuilt 2.4.0 release-pack ZIP to `incoming/drop`; that workflow also imports the source tree.
- YAML validation: PASS — https://github.com/Krenas/DNS-Connect/actions/runs/42670275674.

## Device testing
No phone attached; `adb devices -l` empty. No emulator/system image or `/dev/kvm`. Real install, Wi-Fi/mobile DNS, widgets, Quick Settings, notifications and PackageInstaller handoff are **NOT TESTED**.

## Continuation rules
1. Re-check GitHub release/latest.json/Actions before claiming publication.
2. Preserve Russian UI, existing design, navigation and responsiveness.
3. Never change signer.
4. Never update latest.json before verified Release assets.
5. Separate PASS, FAIL and NOT TESTED.
6. User can download files, click links, upload one ZIP and confirm Android prompts; do not ask for local terminal/build work.
