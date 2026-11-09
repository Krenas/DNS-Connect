# NEXT-CHAT — DNS Connect

**Новый чат запускай внутри существующего ChatGPT Project «DNS».** Это постоянная точка продолжения проекта.

Сначала прочитать:
1. `HANDOFF.md`
2. `CHECKPOINT.md`
3. Текущий статус GitHub main / releases / latest.json.

Не просить пользователя повторно описывать проект и не требовать повторной загрузки Project Files, пока они есть в Project.

## Что делать
- Продолжать существующий Android app DNS Connect, не начинать новый проект и не делать редизайн с нуля.
- Project Files: `2.1.0.zip` (исходники + APK), `Download Zip.zip` (offline SDK 35 bundle), `HB_AI_Xbox_DNS.exe` (Windows reference).
- Публичный репозиторий: https://github.com/Krenas/DNS-Connect
- Package ID: `ru.krenas.dnsanalytics`.
- Существующая эмблема с тремя серверами уже используется в regular/round launcher и app toolbar. Android 13+ themed/monochrome mismatch исправлен дополнительным патчем.
- Основной patch bootstrap и supplemental branding/UI test patch лежат в `bootstrap/patch-2.3.0/`. Используй текущий `manifest.json` и rebuild script — не старые хеши из истории.
- Локально собран candidate 2.3.0 с сохранённой подписью. APK SHA-256: `6bc23aeaf3dd45f0541c1f49b74425415d204bb433272a3348a1fced37d83eb9`; source ZIP: `0476dbeb7d4e322007ad47c4d489ac52e730bfdb709be95f0564f336066b04ea`; release pack: `52b6fb2a28676fffbd28c6c74f0e2f05107d5cb275d72a64f09ee7c2a62e6ad9`. Размеры и полный QA — в `CHECKPOINT.md`. Новый supplemental patch исправляет упаковщик; не предполагать, что старые пути `/mnt/data` существуют.

## Достигнутый QA
- 2.3.0 / versionCode 24.
- 266 automated PASS / 0 FAIL: 108 self-tests, 17 catalogue, 141 UI/resource/navigation/theme/updater.
- apksigner v2/v3 and zipalign PASS.
- Source ZIP safety PASS.
- Physical device, live DNS, widgets, Quick Settings, in-app update download/install: NOT TESTED.

## Важная миграция подписи
Публичный APK 2.1.0 подписан сертификатом `7767de2b...`; новый кандидат 2.3.0 — сохранённым сертификатом 2.2.x `4dc48085...`. Подписи несовместимы. 2.3.0 не обновит установку 2.1.0 напрямую; требуется миграция/reinstall. На 2.2.x с сохранённым сертификатом обновление совместимо. Никогда не публиковать signing key/password.

## Что блокирует публикацию
- Release v2.3.0 ещё не создан и не загружен.
- Public `latest.json` ещё указывает на 2.1.0.
- Cloud build workflow требует два Actions secrets: `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`; последний secret-check показал, что оба отсутствуют.
- В текущем подключении GitHub нет действия для загрузки release binary assets/создания repository secrets. Сборка уже выполнена локально с ключом из приватного репозитория; не публиковать ключ. Продолжить поиск безопасного способа загрузить проверенные APK/source assets или использовать Actions workflow.
- Не менять `latest.json` до загрузки APK/source/checksums и проверки SHA/size у GitHub Release assets.

## Продолжать циклическую проверку
Проверять и исправлять все обнаруженные сбои, запускать тесты снова, фиксировать PASS/FAIL/NOT TESTED. Физические проверки не отмечать PASS без реального устройства. После каждого milestone обновлять HANDOFF.md и CHECKPOINT.md в публичном репозитории.
