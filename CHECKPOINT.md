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
- APK size 1,202,232 bytes; SHA-256 `b376f8f15e6bcf815845bdb65bb6cd204703a5f9d21282b63a658f86d1407ff4`.
- Source ZIP size 1,006,209 bytes; SHA-256 `6a2f58e6dda10a94963992c2ede9a2976a07c1d0a59e9a08b2873809b827ba0a`.
- Release pack size 1,972,455 bytes; SHA-256 `39411fa462904d776f6212c7c2dd46c42f4ffa57d02ecdcadaaf1c352aa5a681`.
- Automated QA: 266 PASS / 0 FAIL (108 self-tests, 17 catalogue tests, 141 UI/resource/navigation/theme/updater checks).
- Separate icon audit: PASS (24 glyph types).
- apksigner v2/v3: PASS. zipalign: PASS.
- Source ZIP unzip/safety audit: PASS; no signing keys, passwords, private secrets, or unsafe paths.
- Build does NOT prove physical-device installation or live network/updater runtime.

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
- Latest patch verification run: https://github.com/Krenas/DNS-Connect/actions/runs/42587450681
