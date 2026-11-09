# DNS Connect 2.3.0 — QA report

## Build identity

- Application: DNS Connect
- Package: `ru.krenas.dnsanalytics`
- Version: `2.3.0` / `versionCode 24`
- `minSdk`: 26 (Android 8.0); `targetSdk`: 35
- Candidate APK: 1,202,232 bytes
- Candidate APK SHA-256: `6bc23aeaf3dd45f0541c1f49b74425415d204bb433272a3348a1fced37d83eb9`
- Source ZIP: 994,948 bytes; SHA-256 `0476dbeb7d4e322007ad47c4d489ac52e730bfdb709be95f0564f336066b04ea`
- Updated release pack: 1,961,751 bytes; SHA-256 `e5354978a4c06b91505f0cea60991a135eb7f0c5e0ffb8fa0c825047c1eaaa60`

## Automated tests — PASS

- Java logic/self-tests: **108 PASS / 0 FAIL**.
- Resolver catalogue: **17 PASS / 0 FAIL**.
- UI, resources, navigation, themes, updater and Android manifest static regressions: **141 PASS / 0 FAIL**.
- Icon glyph map audit: **24 glyph types PASS**.
- Total: **266 PASS / 0 FAIL**.
- Android resources compiled and linked with `aapt2`.
- Every app Java source compiled against Android API 35 stubs using Java 17 bytecode target.
- DEX generated with D8; `classes.dex` independently matches the supplied release APK byte-for-byte.
- All 26 APK ZIP entry contents match byte-for-byte between the supplied candidate and an independent clean rebuild from the included source ZIP.
- Candidate package/version/SDK/application label checked with `aapt`: PASS.
- APK signature verification: v2 PASS, v3 PASS; v1 disabled as intended.
- ZIP alignment: PASS.
- Persistent private JKS certificate SHA-256 equals the candidate APK signer SHA-256: `4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90`.
- Source ZIP: 96 entries; ZIP integrity PASS; no unsafe paths, symlinks, duplicate names, signing keys, password files, APK/idsig files or patch rejects.
- Manifest inspection: launcher Activity, six widget receivers, updater job, private update-file provider, speed foreground service and Quick Settings tile are present. Component exported/protection attributes were inspected.

## Device/runtime testing — NOT TESTED

This execution environment has no attached Android device (`adb devices -l` returned an empty device list), no `/dev/kvm`, and no Android Emulator binary or system image. The available SDK archive contains command-line tools, platform-tools, Android platform 35 and build-tools, but not the Emulator package. Network access from the build container is unavailable, so an emulator could not be installed here.

Consequently, the following require a real phone and are explicitly **NOT TESTED**:

- Install and first launch on physical Android 8–16 devices.
- Wi-Fi and mobile-network DNS probes against live resolvers.
- Live reachability, CDN/service checks and location/network diagnostics.
- Home-screen widget add, resize, refresh and tap behavior in an actual launcher.
- Quick Settings tile add, start/stop behavior and Android 14+ tile UI.
- Notification permissions and background speed-monitor service behavior.
- Download and installation handoff through Android Package Installer from a published Release.
- Actual upgrade behavior on an already-installed 2.2.x build.

The 108 logic tests include a local fake DNS resolver; these are not a substitute for testing the user's ISP, carrier or Wi-Fi network.

## Signing decision and migration boundary

- Continue using the preserved DNS Connect 2.2.x signing key. Its certificate was checked against the JKS in the private repository and matches this 2.3.0 APK exactly. **Do not create another key**; keeping this signer stable preserves future in-place updates from 2.2.x and 2.3.x onward.
- Public 2.1.0 was signed with a different certificate (`7767de2ba22670531c53ca6c76ea74e82c4d140f0907727644b2cd0864840c2b`). 2.3.0 uses `4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90`.
- A valid Android signing-key rotation lineage cannot be created without the old 2.1.0 private key. The signing history in the private source repository begins with the 2.2.x key; no earlier 2.1.0 key was present there. Do not claim 2.1.0 can be updated in place.
- An installation signed by the public 2.1.0 key must be uninstalled before installing 2.3.0. Uninstalling can delete local app data. After migration, keep the current signer unchanged for all subsequent releases.

## Publication state

- Candidate is locally built and independently verified, but public GitHub Release `v2.3.0` is **not published**.
- Public `latest.json` remains on `2.1.0` until the APK, source ZIP and checksums are uploaded and verified as GitHub Release assets.
- This prevents the in-app updater from advertising a release that does not yet exist.
