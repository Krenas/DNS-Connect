# DNS Connect — checkpoint 2026-11-09

## С чего продолжать
Единая инструкция для нового чата: [NEXT-CHAT.md](NEXT-CHAT.md). Сначала прочитать его, затем [HANDOFF.md](HANDOFF.md).

## Установленный baseline
- Public repo: `Krenas/DNS-Connect`, default branch `main`.
- Package: `ru.krenas.dnsanalytics`.
- Public latest: 2.1.0 / versionCode 22.
- Source base: Project File `2.1.0.zip`; содержит `DNS-Connect-2.1.0-source.zip` и APK.
- SDK archive: Project File `Download Zip.zip`; Windows reference: `HB_AI_Xbox_DNS.exe`.
- Не просить повторную загрузку Project Files.

## 2.3.0 patch / source
- Public permanent patch: `bootstrap/patch-2.3.0/`, 13 chunks + manifest.
- Base64 SHA-256: `9a77468bebbe2b5b5e5f412a125f9dec160c5f9e85e2dbd4971388c7a93233ba`.
- Gzip SHA-256: `c08066e4be234e3405baa0dc0a563b3e5dce07036a81194846169807033c4f47`.
- Unified diff SHA-256: `0d2e4baaa30f1d336f32a6f92f293536f3b12498681f641d4870ff9c16a756d1`.
- В текущем продолжении восстановлена исходная база; patch dry-run и apply с `--fuzz=0` прошли; итог source identity 2.3.0 / code 24.
- Зафиксированный прошлым runtime кандидат APK: 1,202,232 bytes, SHA `9cc3bb050e4efd9fa74d161e4f2e2ec6e034b8f9ec2095f79233c178aaa1bc56`. Сам бинарник не сохранён в Project Files; не выдавать его за текущий доступный артефакт.

## QA status
- Предыдущий полный automated report: 266 PASS / 0 FAIL (108 self-tests, 17 catalogue, 141 UI/resource/navigation/theme/updater checks; signature v2/v3, zipalign PASS).
- Текущее продолжение: patch apply, UI audit, catalogue 17/17, glyph/resource checks заявлены PASS.
- Device install, live DNS/network, widgets/Quick Settings runtime и live in-app updater installation: NOT TESTED.

## Branding/icon
- Найдена существующая app-brand эмблема с тремя серверными блоками: `app/src/main/res/drawable-nodpi/ic_dns_connect_foreground.png`.
- Four adaptive launcher variants (regular/round, normal/API33+) and app toolbar already reference this foreground image.
- Android 13+ monochrome launcher was a mismatch; fixed by `bootstrap/patch-2.3.0/branding-3server-monochrome.patch` (3,058 bytes, SHA-256 `549bc339abbc254c460775de3b12cf9337050674ca52b7f1e127af9847a43c2c`).
- Rebuild entry point now applies the extra patch and checks all launcher XML refs + toolbar and three-server geometry. CI run 42584359364 SUCCESS, including zero-fuzz patch application and bash syntax.
- In APK 2.1.0, bottom-tab «Сервисы» is glyph `apps` (four squares), generic `server` glyph is two rack bars. Both are functional glyphs, not the app brand logo. Keep Quick Settings and widget icons purpose-specific.
- Previous pre-branding candidate APK/source hashes are superseded and must not be published. Current branded 2.3.0 APK/source still requires rebuild and fresh hash/signature/zipalign tests.

## Signing / cloud build
- Сохранённый signer fingerprint: `4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90`.
- В актуальной публичной сборке требуется ДВА secrets: `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`. Старые инструкции о четырёх secrets устарели.
- Последний check run 42567494139: оба secrets отсутствуют.
- В текущем GitHub connector нет операции создания/обновления Actions secrets. Нельзя выставить их автоматически этим набором инструментов.
- Никогда не коммитить JKS/password или Base64 signer в public repo.

## Real GitHub state
- Main does not yet contain Android Gradle app project.
- Release 2.3.0 not published; existing releases are duplicate 2.1.0 entries.
- latest.json remains 2.1.0 / code 22 / SHA `c05e9cb8af2b4193ba2c77fb29bcb889e7588af4e61825af34c92af900c09755`.
- Main CI lint/patch integrity run 42567494192: SUCCESS.
- Build-from-archive workflow is prepared but no real source ZIP 2.3.0 was committed to `incoming/`; no 2.3.0 release asset verification has occurred.

## Next actions in priority order
1. Inspect exact Services three-server icon in Project source archive and implement same symbol for launcher/adaptive icon/app-icon placements.
2. Rebuild complete 2.3.0 source + APK from Project base + permanent patch + SDK archive, preserving signing certificate.
3. Verify APK identity, signature, zipalign, source ZIP safety and hashes.
4. Resolve missing two repository secrets without exposing key material; if connector cannot write secrets, report the one exact manual action.
5. Import validated Gradle source into public main or use build-from-archive workflow; publish release assets, verify digest/size, then update latest.json.
6. Test updater and UI on a physical Android device; do not mark these checks PASS before real device evidence.

## Verified workflow links
- Build/publish: https://github.com/Krenas/DNS-Connect/actions/workflows/build-from-archive.yml
- Signing secret check: https://github.com/Krenas/DNS-Connect/actions/workflows/check-release-secrets.yml
- Add missing secrets: https://github.com/Krenas/DNS-Connect/settings/secrets/actions
