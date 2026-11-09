# DNS Connect 2.4.0 — QA and updater verification

## Release identity
- App: DNS Connect
- Package: `ru.krenas.dnsanalytics`
- Version: `2.4.0`
- versionCode: `25`
- minSdk: 26 (Android 8.0+); targetSdk: 35
- APK size: 1,198,136 bytes
- APK SHA-256: `d8e0e07de730161015cdfa6d9d985ed83619969bb526390c72c8bf85e12b4822`
- Source ZIP size: 995,791 bytes
- Source ZIP SHA-256: `2ac314c55f5d553cdb62141d9e41ad109bcdca688b659710ef5ed005e361afd1`
- Release pack size: 1,952,221 bytes
- Release pack SHA-256: `a2b4e5561e35212ce3a36a8cbac252b11a2a3e216f0143358060a2237f6a430f`

## Updater behavior
- Settings expose a single action: **«Проверить и обновить»**.
- One tap fetches the GitHub manifest, compares the installed version, downloads the APK and performs all validation.
- The updater checks approved GitHub release URL/redirect hosts, exact byte count, SHA-256, app package, versionName, strictly increasing versionCode and APK signer identity.
- On success it passes the verified APK to Android's Package Installer.
- The first update may cause Android to ask once for permission to install unknown apps from DNS Connect. Android then displays the install confirmation. The app does not bypass this system confirmation.
- Optional daily background checking remains separate; it only sends an availability notification and never silently downloads or installs.

## Automated checks
- Logic/self-tests: 108 PASS / 0 FAIL.
- Resolver catalogue: 17 PASS / 0 FAIL.
- UI/resources/navigation/theme/updater static regression: 141 PASS / 0 FAIL.
- Total: **266 PASS / 0 FAIL**.
- Android resources compiled and linked with aapt2.
- Java sources compiled against Android API 35; D8 generated DEX.
- APK package/version/versionCode verified with aapt.
- APK signature v2 and v3 verified; zipalign PASS.
- Private retained JKS certificate SHA-256 exactly matches APK signer: `4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90`.
- Independent source rebuild was compared against the supplied APK: all 26 ZIP entries, including DEX, manifest and resources, match byte-for-byte.
- Source ZIP: 96 entries, valid archive; no duplicate entries, unsafe paths, symlinks, private signing files, passwords, APK/idsig files or patch debris.
- Candidate APK/source identity, size and SHA-256 values recorded. The public publisher derives release metadata directly from the embedded APK and source ZIP; it does not depend on a sidecar JSON manifest.
- Public release workflow actionlint/ShellCheck: PASS. GitHub Actions no-pack dry-run: PASS (run 42652482963); actionlint/ShellCheck and full patch verification PASS (run 42652466884). The dry run correctly skips publishing when no pack exists. Full asset verification/Release creation/latest.json update have NOT been run because the pack has not yet been committed to the upload folder.

## Signing decision
- Keep the existing private DNS Connect 2.2.x signing key for 2.4.0 and all later versions.
- Candidate certificate SHA-256: `4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90`.
- This matches the previously verified 2.3.0 candidate. Therefore 2.3.0 → 2.4.0 is signer-compatible; future releases must reuse this exact key.
- Public 2.1.0 uses certificate `7767de2ba22670531c53ca6c76ea74e82c4d140f0907727644b2cd0864840c2b`. Its private key is unavailable and no valid Android key-rotation proof can be made without it. Thus 2.1.0 cannot update in-place; it needs one-time uninstall/reinstall. Uninstalling may erase local data, so make an app backup first. Thereafter updates from 2.4.0 onward can install in-place.

## Device/runtime status — NOT TESTED
No physical Android device is attached to the available environment; ADB returned no devices. No KVM or Android Emulator/system image was available. The following remain NOT TESTED on real hardware:
- First install and in-place upgrade through Android Package Installer.
- Wi-Fi/mobile live DNS queries and reachability.
- Home-screen widget add/resize/update/tap behavior.
- Quick Settings tile add and control.
- Daily background job/notification behavior under real Android power management.
- Actual end-to-end in-app download from a public Release, as the GitHub release assets are not yet published.

## Publication state
- Public GitHub Release `v2.4.0` has NOT been published.
- Public `latest.json` correctly remains on 2.1.0 until the Release assets have been uploaded and verified.
- The public one-file publishing workflow is ready at `.github/workflows/publish-release-pack.yml`. It accepts one ZIP in `incoming/drop/`, verifies it, imports the source, creates/uploads/publishes the release, verifies the GitHub asset digests and only then updates `latest.json`.
- The one-time manual action required from the owner is to upload the release pack at: https://github.com/Krenas/DNS-Connect/upload/main/incoming/drop and commit it. No signing secret or private key is required for this path.
