# DNS Connect — контрольная точка на 2026-11-08

## Непрерывность между чатами
- Новый чат создаётся внутри того же ChatGPT Project DNS.
- Не просить пользователя повторно прикреплять Project Files.
- Сначала читать HANDOFF.md и этот CHECKPOINT.md, затем сверять Project Files, Library и GitHub.
- Project Files: 2.1.0.zip, Download Zip.zip, HB_AI_Xbox_DNS.exe. У Project file IDs и пути в HANDOFF.
- APK/source 2.3.0 не сохранены в Project Files/Library; Library storage limit prevented saving another copy. Не заявлять, что локальные пути предыдущего runtime будут доступны в новом чате.
- 2.3.0 теперь восстанавливается из базы Project 2.1.0.zip + постоянного GitHub patch в bootstrap/patch-2.3.0/.

## Проверенная сборка 2.3.0 (текущий runtime)
- Version 2.3.0, versionCode 24; package ru.krenas.dnsanalytics; minSdk 26; targetSdk 35.
- APK size 1,202,232; SHA-256 9cc3bb050e4efd9fa74d161e4f2e2ec6e034b8f9ec2095f79233c178aaa1bc56.
- Source ZIP size 1,006,206; SHA-256 cb3f80e694d81fe8b615e374260b9b2e5ffdb759660ad8e4d160bdb2c982edc2.
- Release pack SHA-256 43c6ddaf71e79fd631222d19b85e101810debf8b3158b3cfe8ff45f27b29c13b.
- Signing certificate SHA-256 4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90.
- Automated tests: self tests 108 PASS/0 FAIL; resolver catalogue 17 PASS/0 FAIL; UI/resource/navigation/theme/updater audit 141 PASS/0 FAIL; total 266 PASS/0 FAIL.
- APK Signature Scheme v2/v3 PASS; zipalign PASS; identity and version PASS.
- Physical Android, live Wi-Fi/mobile DNS, widgets/Quick Settings runtime, in-app APK installation: NOT TESTED.

## Постоянный patch и rebuild
- Public path bootstrap/patch-2.3.0/: 13 Base64 fragments + manifest.json + README.md.
- Every chunk was fetched again and matched expected byte length and SHA-256: 13/13 PASS.
- Base64 SHA-256 9a77468bebbe2b5b5e5f412a125f9dec160c5f9e85e2dbd4971388c7a93233ba; gzip SHA-256 c08066e4be234e3405baa0dc0a563b3e5dce07036a81194846169807033c4f47; unified diff SHA-256 0d2e4baaa30f1d336f32a6f92f293536f3b12498681f641d4870ff9c16a756d1.
- Clean apply to original 2.1.0 source ZIP passed; resulting source identity is 2.3.0 / code 24.
- One-command rebuild driver: bootstrap/rebuild-dns-connect-from-project-files.sh. It extracts source from Project 2.1.0.zip, verifies/assembles patch, applies zero fuzz, creates source ZIP, extracts SDK from Download Zip.zip, compiles, tests, signs with saved keystore and packages release.
- Script needs preserved JKS from private repo and DNS_RELEASE_KEYSTORE_PASSWORD in protected environment; never log the password.

## Публичный GitHub status — последняя сверка
- Public Release v2.3.0: NOT PUBLISHED.
- latest.json: still version 2.1.0, versionCode 22, SHA-256 c05e9cb8af2b4193ba2c77fb29bcb889e7588af4e61825af34c92af900c09755.
- public main: documentation/workflows/patch only; Android app/ Gradle project not yet imported.
- public releases only the two duplicate 2.1.0 tags (v2.1.0 and 2.1.0).
- in-app updater code is present and verifies manifest/downloaded APK; it cannot discover 2.3 until public Release + latest.json are published.
- publish-uploaded-release.yml only publishes prebuilt APK/source binary blobs; it does not compile.
- build-release.yml can compile source in public main but needs app sources imported and four Actions secrets (keystore base64/password/alias/key password), currently not configured.
- Current GitHub connector exposes no direct Release asset upload and no Actions secret create/update tool. Do not claim publication or automatic cloud build is operational.

## Successful prior publication method 2.1.0
https://github.com/Krenas/DNS-Connect/actions/runs/42395405220
Workflow downloads APK from a pre-existing staging Release with tag 2.1.0, validates SHA/size, attaches the same APK to canonical Release v2.1.0, verifies asset digest, then updates latest.json. It does not build APK from source.

## Signing and migration
- Permanent signer alias dnsconnect; certificate SHA-256 4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90; key is in private Krenas/DNS-Analytics/signing.
- 2.1.0 uses another certificate. First transition: backup → uninstall old 2.1.0 → install 2.3.0 → restore. Later builds use same key and can be installed through Android Installer after explicit user confirmation.

## Следующие шаги
1. In any new chat, rebuild 2.3.0 from Project inputs and permanent patch if artifacts are unavailable.
2. Resolve final publication route: binary upload to the prebuilt publisher, or import source into main and configure the four protected GitHub Actions secrets so build-release.yml can sign/build/publish.
3. Publish Release v2.3.0, verify APK/source asset sizes and SHA-256, then update latest.json and re-fetch public manifest.
4. Verify in-app updater sees 2.3.0 and downloads/verifies it. Physical PackageInstaller handoff requires a handset test.
5. Continue updating this file after each significant action.

## Limits
Tests above are automated offline checks. They do not certify real-world DNS behavior on the user's network, physical UI appearance, widget runtime, or real Android installer success.
