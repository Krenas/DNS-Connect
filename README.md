# DNS Connect

Android-приложение для диагностики DNS-резолверов, интернет-подключения и выбранных сервисов.

- Package: ru.krenas.dnsanalytics
- Android 8.0+ (API 26)
- Публичный репозиторий: https://github.com/Krenas/DNS-Connect
- Постоянная инструкция: HANDOFF.md
- Контрольная точка: CHECKPOINT.md

## Скачать
- Последний опубликованный релиз: https://github.com/Krenas/DNS-Connect/releases/latest
- Все релизы: https://github.com/Krenas/DNS-Connect/releases
- Манифест встроенного обновления: https://raw.githubusercontent.com/Krenas/DNS-Connect/main/latest.json

## Продолжение без повторной загрузки файлов
Создавайте новый чат внутри существующего ChatGPT Project DNS. Project Files проекта уже содержат входную базу 2.1.0.zip, Android SDK tooling Download Zip.zip и HB_AI_Xbox_DNS.exe. Новый чат должен прочитать HANDOFF.md и CHECKPOINT.md, затем использовать постоянный патч из bootstrap/patch-2.3.0/ и скрипт bootstrap/rebuild-dns-connect-from-project-files.sh. Повторно загружать эти файлы в ChatGPT не нужно.

## Повторяемая сборка 2.3.0
Публичный bootstrap/patch-2.3.0 содержит проверенные 13 фрагментов патча, manifest.json и инструкции. Rebuild driver извлекает 2.1.0 source из Project ZIP, проверяет и применяет патч, создаёт source ZIP, использует SDK archive, компилирует, прогоняет тесты и подписывает APK постоянным ключом из private DNS-Analytics/signing. Пароль подписи передаётся только через защищённую переменную среды; никогда не включайте signing files в public repo/source ZIP.

## Проверенный кандидат 2.3.0
- Version 2.3.0, versionCode 24, package ru.krenas.dnsanalytics.
- APK SHA-256: 9cc3bb050e4efd9fa74d161e4f2e2ec6e034b8f9ec2095f79233c178aaa1bc56.
- Source ZIP SHA-256: cb3f80e694d81fe8b615e374260b9b2e5ffdb759660ad8e4d160bdb2c982edc2.
- Automated QA: 266 PASS / 0 FAIL; signature v2/v3 and zipalign passed.
- Physical Android device, real Wi-Fi/mobile DNS, widgets/Quick Settings runtime and live updater install: NOT TESTED.

## Статус публикации / обновлений
Важное отличие: Release 2.3.0 пока НЕ опубликован. latest.json всё ещё указывает на 2.1.0 и versionCode 22. Поэтому in-app updater не может обнаружить 2.3.0, пока публичный Release и манифест не будут обновлены. Не утверждайте, что кнопка обновления уже работает для 2.3.0 без проверки live manifest и release asset.
Встроенный updater валидирует URL, версию, размер, SHA-256, package ID и сертификат APK перед открытием системного Android Installer. Установка требует подтверждения пользователя.

## Первая миграция и подпись
2.1.0 подписан другим сертификатом. Для первого перехода: сделайте резервную копию данных, удалите 2.1.0, установите 2.3.0 и восстановите копию. Все дальнейшие версии должны сохранять сертификат 2.2.x+.
