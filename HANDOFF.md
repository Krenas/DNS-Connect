# DNS Connect — handoff for new chats

This repository is the persistent source of truth for DNS Connect.

## Start here in every new chat
1. Read this file and `README.md`.
2. Read `latest.json` from the default branch. It identifies the currently published APK, release tag, versionCode and checksums.
3. Open the latest GitHub Release and download its versioned source archive:
   `DNS-Connect-VERSION-source.zip`.
4. Download the APK only when a local artifact is required. Never ask the user to attach source files or APK again when they are already available in this repository.
5. Confirm the source archive version matches `latest.json` before editing or building.

## Canonical links
- Repository: https://github.com/Krenas/DNS-Connect
- Releases: https://github.com/Krenas/DNS-Connect/releases
- Latest published release: https://github.com/Krenas/DNS-Connect/releases/latest
- Update manifest: https://raw.githubusercontent.com/Krenas/DNS-Connect/main/latest.json
- Build and publish workflow: https://github.com/Krenas/DNS-Connect/actions/workflows/build-release.yml
- Repository Actions secrets: https://github.com/Krenas/DNS-Connect/settings/secrets/actions

## Release rules
- Android applicationId: `ru.krenas.dnsanalytics`.
- minSdk 26, targetSdk 35.
- Stable release tag: `vMAJOR.MINOR.PATCH`.
- APK asset name: `DNS-Connect-VERSION-release.apk`.
- Source asset name: `DNS-Connect-VERSION-source.zip`.
- Every release must contain both the APK and the exact source snapshot used to build it.
- The APK must be signed with the preserved 2.2.x signing certificate. Expected SHA-256 certificate fingerprint:
  `4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90`.
- Never commit a JKS, keystore password, private key, or token to this public repository. Signing material belongs only in encrypted GitHub Actions repository secrets.
- The app's updater reads `latest.json`; do not change it manually. The release workflows publish and verify it.
- Do not claim a release is complete until the GitHub Actions run is green and public `latest.json` points at that release.
- Preserve user data and updater compatibility. The original 2.1.0 signing key was not supplied; 2.2.0 uses a new key, so moving from 2.1.0 requires export/backup, uninstall, install 2.2.0 and restore. Subsequent releases signed with the 2.2.x key are compatible.

## Current baseline carried forward
- Last locally validated package: DNS Connect 2.2.0, versionCode 23.
- The 2.2.0 local APK passed package/version/signature checks and had 219 automated assertions PASS, 0 FAIL in the recorded QA report.
- Physical-device installation, launcher widget rendering and live-network checks remain NOT TESTED until tested on a device.
- Check the live repository and latest.json; do not assume this local baseline is already published.

## How to continue without chat attachments
The current source archive and APK are stored as versioned GitHub Release assets. Use the repository and release URLs above in a new chat. Source code should be loaded from the latest release archive or the tracked project files after the first source import. No repeated source/APK upload through ChatGPT chat attachments is needed.
