# NEXT-CHAT — DNS Connect

Создавать новый чат внутри существующего ChatGPT Project «DNS».

Сначала прочитать `PROJECT_STATE.json`, `CHECKPOINT.md`, затем этот файл и `HANDOFF.md`. Сразу проверить фактические GitHub Releases, latest.json, ветку main и последние Actions. Не считать статус из старых заметок текущим, если GitHub говорит иначе.

## Актуальная точка — 2026-11-09

- Приложение: DNS Connect.
- Публичный репозиторий: https://github.com/Krenas/DNS-Connect
- Package ID: `ru.krenas.dnsanalytics`.
- Публичный релиз пока 2.1.0 / versionCode 22; `latest.json` намеренно остаётся на нём до проверки реальных Release assets.
- Последний локальный QA-кандидат: **2.4.0 / versionCode 25**.
- Не просить пользователя снова загрузить Project Files `2.1.0.zip`, `Download Zip.zip`, `HB_AI_Xbox_DNS.exe`.

## 2.4.0 — однокнопочное обновление

В Settings → Updates есть одна кнопка **«Проверить и обновить»**. Один запуск делает всю цепочку: запрашивает latest.json → сравнивает версию → скачивает APK → проверяет URL/host/размер/SHA-256/package/versionCode/сертификат подписи → открывает Android Package Installer. Android всё равно просит системное подтверждение; это штатное ограничение и его не обходить.

Опциональная ежедневная проверка — только уведомление, без фоновой установки или незапрошенной загрузки.

После публикации 2.4.0 и установки этого APK будущие версии будут обновляться через кнопку внутри приложения. Для каждой новой версии разработчик собирает и подписывает APK тем же закрытым ключом, затем формируется release pack. Владелец репозитория выполняет только одноразовую загрузку ZIP в GitHub; GitHub Actions автоматически проверяет, публикует Release и меняет latest.json. После этого пользователю не нужно снова заходить в GitHub ради следующих обновлений.

## Подпись и миграция

- Использовать сохранённый приватный ключ 2.2.x, сертификат SHA-256: `4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90`.
- Сертификат 2.4.0 совпадает с кандидатом 2.3.0. Следующие версии обязаны использовать тот же ключ, не генерировать новый.
- Публичная 2.1.0 имеет другой сертификат `7767de2ba22670531c53ca6c76ea74e82c4d140f0907727644b2cd0864840c2b`; её закрытый ключ не найден. Переход с 2.1.0 требует однократной деинсталляции и чистой установки 2.4.0; локальные данные могут быть потеряны. Предупредить сделать резервную копию. Версии, подписанные ключом 2.2.x/2.4.0, будут обновляться поверх друг друга.

## Кандидат и файлы

- APK 2.4.0: 1,198,136 bytes; SHA-256 `d8e0e07de730161015cdfa6d9d985ed83619969bb526390c72c8bf85e12b4822`.
- Source ZIP: 995,791 bytes; SHA-256 `2ac314c55f5d553cdb62141d9e41ad109bcdca688b659710ef5ed005e361afd1`.
- Release pack: 1,952,221 bytes; SHA-256 `a2b4e5561e35212ce3a36a8cbac252b11a2a3e216f0143358060a2237f6a430f`.
- QA: 266 PASS / 0 FAIL (108 self-tests, 17 catalogue, 141 UI/resource/navigation/theme/updater); icon audit covers 24 glyph types.
- Source ZIP has 96 entries and passed archive safety/integrity checks. APK signature v2/v3 and zipalign passed. Independent source rebuild matched all 26 APK ZIP entry contents.
- Physical installation, live Wi-Fi/mobile DNS, widgets, Quick Settings and real Package Installer are **NOT TESTED**; no device/ADB/emulator/KVM exists in the runtime.

## Единственное действие владельца для первой публикации 2.4.0

Скачать [DNS-Connect-2.4.0-release-pack.zip](https://github.com/Krenas/DNS-Connect/releases) из текущего чата и открыть upload page:
https://github.com/Krenas/DNS-Connect/upload/main/incoming/drop

На странице загрузить один файл `DNS-Connect-2.4.0-release-pack.zip` и нажать Commit changes. Не класть JKS/пароли/секреты: pack содержит только уже подписанный APK, исходники и QA.

Публичный workflow `.github/workflows/publish-release-pack.yml` самостоятельно:
1. Находит APK/source/QA внутри release pack.
2. Вычисляет SHA-256 и размеры из самих файлов; JSON sidecar не требуется.
3. Проверяет APK package/version/versionCode, signer, v2/v3 и zipalign.
4. Проверяет безопасность ZIP исходников и что исходники содержат однокнопочный updater.
5. Импортирует исходники в main.
6. Создаёт GitHub Release, загружает APK/source/QA/checksums.
7. Сверяет GitHub asset digest и size.
8. Только после этого публикует Release и меняет latest.json на новую версию.
9. Удаляет временный release pack.

Secrets для этого pre-signed upload path не требуются; приватный ключ не покидает закрытое хранилище.

- Publisher no-pack dry-run PASS: https://github.com/Krenas/DNS-Connect/actions/runs/42650867597
- actionlint/ShellCheck проверки workflow PASS: https://github.com/Krenas/DNS-Connect/actions/runs/42650678457
- Поскольку pack ещё не закоммичен в incoming/drop, реальные шаги создания Release и latest.json пока не выполнялись. Не заявлять, что публичное автообновление уже активировано.

## Правила продолжения

- Не начинать проект заново и не редизайнить приложение.
- Не генерировать новый signing key; сохранять 2.2.x key.
- Не публиковать latest.json до настоящей проверки release asset digests.
- Не считать no-pack dry-run полной проверкой релиза.
- Не называть физические тесты PASS без настоящего Android.
- После каждого существенного действия обновлять PROJECT_STATE.json/CHECKPOINT.md/HANDOFF.md.
