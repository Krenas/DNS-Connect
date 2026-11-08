# DNS Connect 2.3.0 — reproducible source patch

This folder reconstructs the 2.3.0 source tree from the original 2.1.0 source ZIP stored inside the persistent ChatGPT Project file `2.1.0.zip`.

## Verified patch integrity

- Base version: 2.1.0 / versionCode 22.
- Target: 2.3.0 / versionCode 24 / package `ru.krenas.dnsanalytics`.
- Patch representation: 13 UTF-8 Base64 text chunks, decoded into a gzip-compressed unified diff.
- Encoded payload: 38,132 bytes, SHA-256 `9a77468bebbe2b5b5e5f412a125f9dec160c5f9e85e2dbd4971388c7a93233ba`.
- Gzip payload: 28,598 bytes, SHA-256 `c08066e4be234e3405baa0dc0a563b3e5dce07036a81194846169807033c4f47`.
- Uncompressed unified diff: 119,074 bytes, SHA-256 `0d2e4baaa30f1d336f32a6f92f293536f3b12498681f641d4870ff9c16a756d1`.
- Every chunk length and SHA-256 is listed in `manifest.json`; each of the 13 public chunk files was independently re-fetched and matched its recorded hash.
- A clean patch-apply test against the original 2.1.0 source ZIP passed.

## How a new chat continues without a user re-upload

Create the new chat inside the same ChatGPT Project DNS. The three persistent Project Files are:
- `2.1.0.zip` — contains `DNS-Connect-2.1.0-source.zip` and the prior 2.1.0 APK.
- `Download Zip.zip` — offline Android platform 35 / build-tools 35 package.
- `HB_AI_Xbox_DNS.exe` — original Windows reference executable.

A new assistant must not ask the user to attach these files again. It must:
1. Read the public `HANDOFF.md` and `CHECKPOINT.md`.
2. Locate the Project Files from the current Project.
3. Read this folder's `manifest.json`.
4. Fetch the 13 chunks `000.b64` ... `012.b64` from this folder using the connected GitHub tool (or raw GitHub URLs).
5. Rebuild using the single entry point below.

## Single rebuild entry point

The repository includes `bootstrap/rebuild-dns-connect-from-project-files.sh`. It:
- extracts the 2.1.0 source ZIP from the outer Project archive;
- downloads or accepts cached patch chunks;
- validates all chunk hashes, the complete Base64 payload, gzip payload and unified diff;
- applies the patch with zero fuzz;
- verifies version/package identity;
- creates a clean 2.3.0 source ZIP;
- extracts the SDK platform/build tools from `Download Zip.zip`;
- builds, tests, signs and packages the APK using the preserved private signing key;
- verifies the expected signing certificate.

Example (key password must be injected as a protected environment variable, never printed):

```bash
export DNS_RELEASE_KEYSTORE_PASSWORD='(read securely from private signing store)'
bash bootstrap/rebuild-dns-connect-from-project-files.sh \
  '/mnt/data/2.1.0.zip' \
  '/mnt/data/Download Zip.zip' \
  '/secure/path/DNS-Connect-signing-key.jks' \
  '/mnt/data/dnsconnect-release'
```

The optional fifth argument is a directory containing already fetched `000.b64` ... `012.b64` files. Without it the script retrieves the patch files from raw.githubusercontent.com.

## Release status

The locally built 2.3.0 APK and source ZIP have been verified, but public GitHub Release `v2.3.0` has not yet been published. The public `latest.json` still points to 2.1.0. Do not report the in-app updater live until the public release assets and manifest have been published and re-verified.

The updater validates URL, version, package, signer, size and SHA-256 before handing off to Android's package installer. Android still requires the user to confirm installation.

## Signing / safety

The permanent release key stays in private repository `Krenas/DNS-Analytics/signing`. Never copy the keystore or password into this public repository, public source ZIP, logs, artifacts or this patch folder. Never rotate the signer casually: installed builds signed by another certificate cannot be updated in place.
