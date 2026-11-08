# DNS Connect — handoff for new chats

This repository is the persistent source of truth for DNS Connect. Do not ask the user to re-upload APK or project source if the matching version is already in GitHub.

## Start here in every new chat
1. Read this file and `README.md`.
2. Read `latest.json` from the default branch. It identifies the latest published APK, versionCode, checksums, and source archive.
3. Open the latest stable GitHub Release and download its versioned source archive `DNS-Connect-VERSION-source.zip`.
4. Check that archive version, APK version, and `latest.json` agree before editing or building.
5. Treat the tracked `main` tree as the working project after the initial bootstrap. Do not use old chat attachments as the authoritative source.

## Canonical links
- Repository: https://github.com/Krenas/DNS-Connect
- Releases: https://github.com/Krenas/DNS-Connect/releases
- Latest stable release: https://github.com/Krenas/DNS-Connect/releases/latest
- Update manifest: https://raw.githubusercontent.com/Krenas/DNS-Connect/main/latest.json
- One-time source bootstrap: https://github.com/Krenas/DNS-Connect/actions/workflows/bootstrap-source.yml
- Future build/release: https://github.com/Krenas/DNS-Connect/actions/workflows/build-release.yml
- Repository Actions secrets: https://github.com/Krenas/DNS-Connect/settings/secrets/actions

## Current app identity and signing
- Android applicationId: `ru.krenas.dnsanalytics`.
- minSdk 26, targetSdk 35.
- Stable tag: `vMAJOR.MINOR.PATCH`.
- APK asset: `DNS-Connect-VERSION-release.apk`.
- Source archive: `DNS-Connect-VERSION-source.zip`.
- Checksums: `DNS-Connect-VERSION-SHA256SUMS.txt`.
- 2.2.x signing certificate SHA-256:
  `4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90`.
- Never commit a JKS, keystore password, private key, or token to this public repository or any source archive. Store signing material only as encrypted GitHub Actions repository secrets.
- Required secret names: `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_ALIAS`, `ANDROID_KEY_PASSWORD`. The alias is `dnsconnect`; key password equals store password.
- The original 2.1.0 key was not provided. Moving from 2.1.0 to 2.2.0 requires export/backup, uninstall, install 2.2.0, restore. Future updates signed with the 2.2.x key are compatible.

## Initial one-time bootstrap
The Android source was not in `main` when this handoff was added. The user must publish a `v2.2.0` GitHub Release with these two assets:
- `DNS-Connect-2.2.0-release.apk`
- `DNS-Connect-2.2.0-source.zip`

Then they run the bootstrap workflow on `main`, with input `v2.2.0`. It validates APK and source archive, imports source files into `main`, and updates `latest.json`. Do not claim this is complete until the workflow has a green run and the source files are visible in `main`.

## Future release process
After source import:
1. Make changes in the project tracked in `main`.
2. Increase `versionName` and `versionCode` in `app/build.gradle.kts`.
3. Run the build workflow from `main` with the new stable tag and release notes.
4. Wait for green checks. The workflow builds/signs APK, creates source archive and checksum file, publishes them to Releases, and updates `latest.json`.
5. Verify public manifest and Release assets before telling the user the release is complete.

## Current baseline (local artifacts; not yet published)
- Locally validated package: DNS Connect 2.2.0, versionCode 23.
- Local APK hash: `86c769d4e6c1e3f05968bc404a67b74820696f6b6fb2f6b54f64b0791cdac955`.
- Local source ZIP hash: `e6ee0587d838488e673b4d2c39a47a28e67d063ab185f15f99838e75557b411c`.
- Local automated test report: 219 PASS, 0 FAIL.
- Physical-device install, live network tests, and real update installation remain NOT TESTED.
- Re-read live GitHub status and `latest.json`; do not assume local 2.2.0 is already released.
