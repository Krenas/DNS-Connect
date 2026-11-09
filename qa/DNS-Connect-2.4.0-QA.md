# DNS Connect 2.4.0 — QA report

## Release identity
- App label: DNS Connect
- Package: `ru.krenas.dnsanalytics`
- Version: `2.4.0` (`versionCode` 25)
- `minSdk`: 26 (Android 8.0)
- `targetSdk`: 35
- APK size: 1,198,136 bytes
- APK SHA-256: `1c16821661be3c7ccee6198fbad9823563a09cc3b018cccc5aedbe11d3c33883`
- Signing certificate SHA-256: `54b847350b8f4166ea3add400330f360cbc53c4b82e53d709d2c9ff084eb21f7`

## Automated results
- Regression/self-tests: **108 PASS / 0 FAIL**
- Resolver catalogue: **17 PASS / 0 FAIL** (72 built-in resolver profiles; no duplicate protocol/endpoint pairs)
- UI/navigation/theme/resources/updater checks: **142 PASS / 0 FAIL**
- Combined build-script checks: **267 PASS / 0 FAIL**
- Icon audit: **24 glyph types mapped; PASS**
- Source ZIP: **96 entries; PASS** (ZIP integrity, unique paths, required Gradle/updater files present; no symlinks, path traversal, signing files, password files, or embedded APK)

## APK verification
- `apksigner verify`: **PASS**
- APK Signature Scheme v2: **true**
- APK Signature Scheme v3: **true**
- `zipalign -c -v 4`: **PASS**
- Manifest package/version/SDK metadata: **PASS**
- App label: **DNS Connect**

## In-app update behavior
The Settings page uses one action: **«Проверить и обновить»**. It checks the public GitHub manifest, downloads only when a newer version exists, verifies the APK metadata and SHA-256, checks the installed signing certificate, and hands the verified package to Android's system installer. Android confirmation remains required. Optional daily background checks remain opt-in and do not download or install APK files automatically.

The GitHub Actions source-build workflow uses one repository secret, `DNS_CONNECT_SIGNING_BUNDLE`, containing the release keystore and its password. After that secret is added once, uploading `DNS-Connect-2.4.0-source.zip` to `incoming/` triggers GitHub Actions to compile, test, sign, verify, publish the Release assets, and update `latest.json`.

## Real-device status
**NOT TESTED — physical Android device.** `adb devices -l` returned an empty device list; no Android emulator or `/dev/kvm` is available in this environment. Therefore installation UI, real Wi-Fi/mobile DNS, launcher widgets, Quick Settings tile, notification delivery, background scheduling, and PackageInstaller handoff still require the user's device check. Local fake-resolver tests are not internet benchmarks and are not represented as device/network tests.

## Signing migration note
A new release key was created for 2.4.0 and preserved for future builds. Its certificate fingerprint differs from the old public 2.1.0 certificate and from the earlier unpublished 2.3.0 candidate. Android will not install this as an in-place update over those builds. A one-time uninstall/reinstall may be required; export a backup first because uninstalling can remove app data. Future versions must use the preserved 2.4.0 key to update in place.

## Publication status at QA generation
The APK and source archive are built and verified. The public repository's `latest.json` remains at 2.1.0 until the GitHub Actions build is triggered by uploading the source ZIP after adding `DNS_CONNECT_SIGNING_BUNDLE`. No 2.4.0 public Release is claimed as published in this report.
