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
