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
- A clean patch-apply test against the original 2.1.0 source ZIP passed for the main diff.

## Three-server app icon consistency

The existing `drawable-nodpi/ic_dns_connect_foreground.png` is the DNS Connect brand artwork with three stacked server units, a globe and a DNS shield. The adaptive launcher, round launcher and in-app top-bar brand image already use this same foreground. The Android 13+ themed/monochrome launcher icon previously used an older, unrelated globe/shield illustration with only two server strips. The additional `branding-3server-monochrome.patch` changes that themed icon to a matching three-server rack mark and updates the UI regression assertion that previously expected the outdated globe/shield mark. Its size is 3,710 bytes and SHA-256 is `db74d35e8090a16dea74213703423d2073e2370da7dd3dbae79144c6c42e8362`. The patch is generated against the exact compact XML in the original source ZIP, not JADX's reformatted XML output. It also updates the UI regression assertion to test the new three-server motif. The rebuild entry point applies this supplemental patch after the main 2.3.0 patch and checks all launcher variants and the in-app brand reference. The final local 2.3.0 candidate has since been rebuilt with this patch; all 266 automated tests pass.

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
- applies the main patch, the three-server monochrome branding patch, and the fresh-archive packaging fix with zero fuzz;
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

The pre-branding candidate is superseded; its hashes remain in `manifest.json` for audit only. The current clean local 2.3.0 candidate is: APK SHA-256 `6bc23aeaf3dd45f0541c1f49b74425415d204bb433272a3348a1fced37d83eb9` (1,202,232 bytes), source ZIP SHA-256 `0476dbeb7d4e322007ad47c4d489ac52e730bfdb709be95f0564f336066b04ea` (994,948 bytes), release pack SHA-256 `52b6fb2a28676fffbd28c6c74f0e2f05107d5cb275d72a64f09ee7c2a62e6ad9` (1,961,178 bytes). Automated tests: 266 PASS / 0 FAIL (108 self-tests, 17 catalogue checks, 141 UI/resource/navigation/theme/updater checks); icon audit covers 24 glyph types. apksigner v2/v3, zipalign, package/version, source ZIP integrity and safety PASS. The source ZIP contains 96 files and excludes signing material, APK/idsig output, `.orig/.rej` patch debris and unsafe paths. The packaging script was fixed to recreate ZIPs instead of retaining stale entries. Public GitHub Release `v2.3.0` has not yet been published. The public `latest.json` still points to 2.1.0. Do not report the in-app updater live until release assets and manifest have been published and re-verified.

The updater validates URL, version, package, signer, size and SHA-256 before handing off to Android's package installer. Android still requires the user to confirm installation.

## Signing / safety

The permanent release key stays in private repository `Krenas/DNS-Analytics/signing`. Never copy the keystore or password into this public repository, public source ZIP, logs, artifacts or this patch folder. Never rotate the signer casually: installed builds signed by another certificate cannot be updated in place.
