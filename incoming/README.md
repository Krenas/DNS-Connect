# Incoming source ZIP drop zone

Place a clean source archive here using the name:

`DNS-Connect-MAJOR.MINOR.PATCH-source.zip`

Committing a ZIP matching `incoming/DNS-Connect-*-source.zip` to `main` automatically triggers `.github/workflows/build-from-archive.yml`.

The workflow then:
1. Validates ZIP paths and refuses embedded signing keys/password files.
2. Extracts the Gradle project and checks its app ID, version and versionCode.
3. Runs regression checks, builds the signed APK with Java 17 / Android SDK 35, and checks package/version/signing certificate/zipalign.
4. Creates a draft GitHub Release, uploads the APK/source ZIP/checksums, verifies GitHub asset SHA-256 and sizes, then publishes the Release.
5. Updates `latest.json`, so DNS Connect can discover the update in-app.
6. Removes the temporary source archive from this folder after success.

## One-time repository setup

For the cloud build workflows (`build-from-archive.yml` and `build-release.yml`), configure exactly these two protected repository secrets in Settings → Secrets and variables → Actions:

- `ANDROID_KEYSTORE_BASE64`: Base64-encoded release JKS.
- `ANDROID_KEYSTORE_PASSWORD`: keystore password. The workflow uses the fixed alias `dnsconnect` and the same password for the key.

`ANDROID_KEY_ALIAS` and `ANDROID_KEY_PASSWORD` are not required secrets in the current workflow. The separate `publish-uploaded-release.yml` path verifies and publishes an already-built APK/source pair and does not sign or rebuild them.

The build stops safely if a secret is missing or the APK signer does not match the retained certificate. Never place the JKS or password in this folder, the public repository, or the source ZIP.

The assistant should create this ZIP from the persistent Project source inputs and commit it here. The user does not need to upload the archive manually or run Gradle locally.
