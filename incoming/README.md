# Incoming source ZIP drop zone — GitHub cloud build

Upload a clean Gradle source archive named `DNS-Connect-MAJOR.MINOR.PATCH-source.zip` to this folder and commit it to `main`. This triggers `.github/workflows/build-from-archive.yml`.

## One-time setup

Before the first build, create exactly one protected repository secret:

- Name: `DNS_CONNECT_SIGNING_BUNDLE`
- Value: the full Base64 text from the private file `DNS-Connect-2.4.0-GitHub-Signing-Secret.txt` supplied separately to the repository owner.

The value encodes a ZIP containing `release.jks` and `password.txt`. GitHub Actions decodes it only into the ephemeral runner, verifies the alias and password, masks the password in logs, and removes the files after the job. Never commit the secret file, JKS, password, or Base64 string to the public repository, ZIP, issue, or logs.

Secret page: https://github.com/Krenas/DNS-Connect/settings/secrets/actions/new

## What the workflow does

1. Validates ZIP integrity, safe paths, no duplicate entries/symlinks, no signing material, password files or prebuilt APKs.
2. Extracts the Gradle source and checks package, version and increasing versionCode.
3. Runs UI, catalogue and icon checks.
4. Builds a signed release APK with Java 17 / Android SDK 35.
5. Verifies package, version, certificate fingerprint, APK v2/v3 signatures and zipalign.
6. Creates the GitHub Release, uploads APK/source/checksums and verifies asset size and digest.
7. Updates `latest.json` only after asset verification.
8. Removes the temporary source ZIP after success.

For each later release, keep the same `DNS_CONNECT_SIGNING_BUNDLE` secret and upload the next versioned source ZIP. The user does not need a local terminal or Android SDK.
