# One-file fallback: publish a pre-signed release pack

Use this only when an already-built APK and source ZIP are ready. It publishes the package but does not compile the APK on GitHub. The main cloud-build route is documented in [../README.md](../README.md) and [incoming/README.md](../README.md).

1. Open https://github.com/Krenas/DNS-Connect/upload/main/incoming/drop
2. Upload exactly one file named `DNS-Connect-VERSION-release-pack.zip`.
3. Commit the file to `main`.
4. `publish-release-pack.yml` validates the APK package/version/versionCode, new 2.4.0 signer, v2/v3 signature, zipalign, source ZIP safety and the one-button updater source.
5. It imports the verified source, creates the GitHub Release, uploads APK/source/QA/checksums, verifies the published asset digests and sizes, and only then advances `latest.json`.
6. After success, the temporary pack is deleted.

This fallback does not need `DNS_CONNECT_SIGNING_BUNDLE` because the APK is already signed. Do not upload a raw APK or signing material. Only one release pack may be present at a time.
