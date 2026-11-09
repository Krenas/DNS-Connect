# DNS Connect — checkpoint 2026-11-09

Единая инструкция для нового чата: [NEXT-CHAT.md](NEXT-CHAT.md). Сначала прочитать его, затем [HANDOFF.md](HANDOFF.md).

## Project baseline
- Public repo: `Krenas/DNS-Connect`, branch `main`.
- Package: `ru.krenas.dnsanalytics`; app label DNS Connect.
- Published public version: 2.1.0 / versionCode 22.
- Immutable Project source input: `2.1.0.zip` (contains `DNS-Connect-2.1.0-source.zip` and old APK).
- SDK input: `Download Zip.zip` (Android SDK platform 35 + build-tools 35).
- Windows reference input: `HB_AI_Xbox_DNS.exe`.
- Не просить повторно загружать эти Project Files.

## 2.3.0 locally built release candidate
- Version 2.3.0 / versionCode 24 / package `ru.krenas.dnsanalytics`.
- APK: 1,202,232 bytes; SHA-256 `6bc23aeaf3dd45f0541c1f49b74425415d204bb433272a3348a1fced37d83eb9`.
- Clean source ZIP: 994,948 bytes; SHA-256 `0476dbeb7d4e322007ad47c4d489ac52e730bfdb709be95f0564f336066b04ea`.
- Release pack: 1,961,751 bytes; SHA-256 `e5354978a4c06b91505f0cea60991a135eb7f0c5e0ffb8fa0c825047c1eaaa60`.
- Automated QA: **266 PASS / 0 FAIL** = 108 self-tests + 17 catalogue tests + 141 UI/resource/navigation/theme/updater checks.
- Separate icon audit: PASS (24 glyph types).
- APK: package/version/versionCode verified; apksigner v2/v3 PASS; zipalign PASS; retained signer SHA-256 `4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90`.
- Source ZIP: 96 entries; ZIP integrity PASS; no unsafe paths, symlinks, signing material, APK/idsig, `.orig/.rej` or duplicate entries.
- Packaging defect found and fixed: `zip -r` preserves stale entries in an existing archive. `package-release.sh` now deletes old source/release ZIPs before creating new ones and excludes temporary patch/build files.
- Clean rebuild from original 2.1.0 source with the main patch and supplemental patches; main diff, branding patch and packaging-fix patch are integrated into the rebuild path; all patch hunks apply with `--fuzz=0`.
- This is a locally built release candidate, not a published GitHub Release.
## 2.3.0 patch bootstrap
- Main diff stored in `bootstrap/patch-2.3.0/`, 13 Base64 chunks.
- Base64 SHA-256: `9a77468bebbe2b5b5e5f412a125f9dec160c5f9e85e2dbd4971388c7a93233ba`.
- Gzip SHA-256: `c08066e4be234e3405baa0dc0a563b3e5dce07036a81194846169807033c4f47`.
- Diff SHA-256: `0d2e4baaa30f1d336f32a6f92f293536f3b12498681f641d4870ff9c16a756d1`.
- Supplemental branding + UI assertion patch: 3,710 bytes; SHA-256 `db74d35e8090a16dea74213703423d2073e2370da7dd3dbae79144c6c42e8362`.
- Both diffs apply to original source with `--fuzz=0`.
- Build entry point `bootstrap/rebuild-dns-connect-from-project-files.sh` applies main + supplemental patch and checks launcher references/brand tests.

## Branding/icon result
- Three-server logo foreground: `app/src/main/res/drawable-nodpi/ic_dns_connect_foreground.png` (three server units, globe, DNS shield).
- Manifest regular/round launcher, all four adaptive icon XMLs, and app toolbar use the same foreground.
- Android 13+ monochrome icon was aligned to three server racks; test assertion updated.
- «Сервисы» bottom-nav glyph in APK 2.1.0 is `apps` (four squares), generic `server` glyph means two bars. These are functional navigation glyphs, not the app brand logo.
- System DNS Quick Settings tile stays purpose-specific.

## Signature compatibility boundary
- Original public 2.1.0 APK signer SHA-256: `7767de2ba22670531c53ca6c76ea74e82c4d140f0907727644b2cd0864840c2b`.
- New 2.3.0 APK uses preserved 2.2.x signing identity SHA-256: `4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90`.
- These are different. 2.3.0 can update installations already signed with 2.2.x key; it cannot update 2.1.0 in place. Moving from 2.1.0 requires uninstall/reinstall/migration and may remove local data. Do not promise a seamless update from the public 2.1.0 install.

## Cloud release blocker / current public state
- Public Release 2.3.0 is NOT published.
- Public `latest.json` remains at 2.1.0 / code 22; do not change it until APK/source/checksums are attached to a real release and digests verified.
- Current public build workflow requires exactly two repository Actions secrets: `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`.
- Last signing secret check reported both absent. This GitHub connector has no action to create/update repository Actions secrets. Do not put signing material in public repository.
- Public main has workflows/docs/patch bootstrap, but the complete Gradle project has not yet been imported.
- Current locally built assets are not yet uploaded to GitHub Releases; current chat can deliver sandbox downloads. A new chat can reconstruct from Project Files and the patch, but should re-verify files/hashes before use.

## Real device checks still NOT TESTED
- Physical Android install/update.
- Actual DNS resolver/network probes on Wi-Fi and mobile.
- Widgets and Quick Settings tile runtime.
- In-app download and Android Installer handoff for a published 2.3.0 release.

## Next priority
1. Resolve public artifact upload / release publication path, keeping signer private.
2. Do not overwrite latest.json before release assets verified.
3. Test upgrade on a device already signed with 2.2.x key; plan migration for 2.1.0 signer.
4. Run actual device/network/widget/tile/updater tests and update this checkpoint only with evidence.

## Permanent workflows
- Build/publish: https://github.com/Krenas/DNS-Connect/actions/workflows/build-from-archive.yml
- Signing secret check: https://github.com/Krenas/DNS-Connect/actions/workflows/check-release-secrets.yml
- Settings for the two secrets: https://github.com/Krenas/DNS-Connect/settings/secrets/actions
- Latest patch verification run: https://github.com/Krenas/DNS-Connect/actions/runs/42626033799


## Independent rebuild and real-device availability check — 2026-11-09 14:00 UTC
- Re-extracted the supplied 2.3.0 source ZIP and ran its complete `build-local.sh` with the preserved private JKS. Build completed successfully.
- Independently compiled every Java source against Android API 35, compiled/linked resources with aapt2, generated DEX with D8 and checked the signed APK with apksigner/zipalign.
- Supplied APK and independent rebuild have identical contents for all 26 ZIP entries, including `classes.dex`, resources and manifest. Whole-file digest differs because the signing/container layer was regenerated; both APKs verify against the same certificate.
- Re-ran tests: **108 self-tests PASS / 0 FAIL; 17 catalogue PASS / 0 FAIL; 141 UI/resource/navigation/theme/updater PASS / 0 FAIL; 24 icon glyph types PASS**.
- Independently audited source ZIP: 96 entries, valid ZIP, no unsafe paths, symlinks, duplicate names, signing materials, APK/idsig or patch debris.
- Manifest inspected: launcher, 6 widget providers, updater job, private update provider, speed service and Quick Settings tile; export and permission attributes inspected.
- Device availability: `adb devices -l` empty; `/dev/kvm` absent; no emulator binary/system image in the available SDK bundle; build-container network unavailable. Physical-device, Android UI runtime, launcher widget runtime, Quick Settings runtime, live network and Package Installer tests remain **NOT TESTED**. See [QA report](qa/DNS-Connect-2.3.0-QA.md).
- Release pack refreshed: 1,961,751 bytes; SHA-256 `e5354978a4c06b91505f0cea60991a135eb7f0c5e0ffb8fa0c825047c1eaaa60`.

## Final signing decision
- The 2.2.x private JKS exists in the private repository and its certificate SHA-256 was checked against the 2.3.0 APK: exact match `4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90`.
- Keep this signer for 2.3.0 and all future versions. Do not generate a new key: it would unnecessarily break future in-place updates from this candidate.
- Public 2.1.0 certificate `7767de2ba22670531c53ca6c76ea74e82c4d140f0907727644b2cd0864840c2b` differs. The private signing history starts with the 2.2.x identity; the old 2.1.0 private key was not found. A verified Android signing-rotation lineage cannot be created without that old key.
- Consequently, 2.1.0 must be uninstalled before installing 2.3.0; uninstall may remove app-local data. Upgrades from 2.2.x using the retained signer remain compatible.

## Updated QA references
- Detailed report in the public source repository: `qa/DNS-Connect-2.3.0-QA.md`.
- Candidate APK and source SHA-256 values above remain unchanged.
- Public Release 2.3.0 still not published; `latest.json` stays on 2.1.0 pending verified GitHub Release assets.
