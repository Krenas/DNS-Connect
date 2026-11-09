# One-file release publishing

This folder is the only manual step for publishing a prepared DNS Connect release. The release-pack publisher workflow is active and validates both the asset and the source archive before publishing. Its Android SDK checks use the runner's installed SDK tools.

1. Open https://github.com/Krenas/DNS-Connect/upload/main/incoming/drop
2. Upload exactly one file named `DNS-Connect-VERSION-release-pack.zip`.
3. Commit the uploaded file to branch `main`.
4. GitHub Actions automatically validates the embedded APK, source ZIP, SHA-256 values, package/version, APK v2/v3 signature, zipalign, source archive safety and retained signing certificate.
5. If every check passes, Actions imports the source into `main`, creates/publishes the GitHub Release, verifies the uploaded Release asset digests and only then updates `latest.json`.
6. After success, Actions removes the temporary ZIP from this folder.

No signing secret is needed: the APK is already signed with the preserved private key. The key and password are never uploaded. Do not upload a raw APK here; upload the complete release pack.

A failed workflow leaves the upload ZIP in place so it can be inspected or retried. A successful workflow removes it. Only one release pack may be present at a time.

A deployment dry-run was checked in GitHub Actions. No Release or latest.json is changed until a valid pack is committed.

The dry-run also checks the retained signer using a pipefail-safe extraction command.

The source validation drains complete ZIP entries to avoid short-circuiting the stream under strict shell mode.

The validator derives package version, versionCode, APK size, checksum and signer from the contents of the release pack itself; no sidecar JSON manifest is required.

Source ZIP validation checks the core Gradle app, manifest and updater manager; it does not assume an optional test-script filename.
