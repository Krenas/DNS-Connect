# DNS Connect — постоянный handoff и контрольная точка

## Обязательное правило на каждый ответ
Любое сообщение может оказаться последним в чате. После каждого существенного изменения сохраняй текущее состояние, а не откладывай до завершения диалога:
1. Обнови этот HANDOFF и CHECKPOINT.md: версия, изменённые файлы, точные хеши, пройденные/непройденные проверки, коммиты и следующий конкретный шаг.
2. Сохрани новые APK, source ZIP, build log, QA, audit и release pack в Project Files проекта ChatGPT DNS. Не проси пользователя загружать повторно то, что уже там есть.
3. Если источник/релиз изменились и GitHub доступен, синхронизируй main, README, handoff и release manifest.
4. Чётко различай локальную сборку, вложения Project Files, commit в GitHub, опубликованный GitHub Release и тест на устройстве. Не выдавай одно за другое.

## Как начать новый чат без отправки файлов
Новый чат нужно создавать ВНУТРИ существующего ChatGPT Project «DNS». Project Files доступны чатам этого проекта. Новый чат должен сам найти самый новый DNS-Connect-*-source.zip, DNS-Connect-*-release.apk, QA и CHECKPOINT.md через Files/Project Files. Оригиналы 2.1.0.zip, Download Zip.zip и HB_AI_Xbox_DNS.exe также находятся там. Пользователь не должен их пересылать.
Важно: Download Zip.zip — архив инструментов Android SDK/Gradle, а не исходники Android-приложения.

## Постоянные ссылки
- Публичный проект: https://github.com/Krenas/DNS-Connect
- Releases: https://github.com/Krenas/DNS-Connect/releases
- latest.json: https://raw.githubusercontent.com/Krenas/DNS-Connect/main/latest.json
- Этот handoff: https://github.com/Krenas/DNS-Connect/blob/main/HANDOFF.md
- Приватное хранилище signing key: https://github.com/Krenas/DNS-Analytics/tree/main/signing

## Точный статус на 2026-11-08
- Кандидат DNS Connect 2.3.0, versionCode=24, package ru.krenas.dnsanalytics, minSdk 26, targetSdk 35.
- APK SHA-256: d00426a2cef98d74fcf266b9f0a85d057d15687c5ca3de26c5b72bc9e4a76727.
- APK size: 459641 bytes.
- Source ZIP SHA-256: 51628bd59d2f6ebb431871ea0170925f94d62e601b31b2f2f21c5fa2fab44e0f.
- Release pack SHA-256: 0f2ff4070f990c9f5def1a63e6fa835224caed8fb5f716d22877dbe378162486.
- APK signing certificate SHA-256: 4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90 (same key family as 2.2.x+; private key must never enter public repo).
- Fresh build-local.sh: 234 PASS / 0 FAIL across logic, catalogue, icons, previews, UI, navigation, theme and updater checks.
- package-release.sh: 14 PASS / 0 FAIL.
- Java compile, D8, APK v2/v3 signature, zipalign, metadata: PASS.
- Physical Android device, real-life network and real update install: NOT TESTED.
- Public latest.json still reports 2.1.0. Public Release v2.3.0 does not yet exist. Public main/app/build.gradle.kts is not present. 2.3.0 is a locally rebuilt candidate and Project Files attachment, not a published GitHub release.

## Изменения 2.3.0
Перестроена логика экранов вокруг обзора/единого действия. Инструменты и настройки разделены на самостоятельные меню/окна. Добавлены 20 акцентных цветов, выделение выбранных категорий, тёмная нижняя системная панель, независимые DNS-purpose filters, отдельный выбор сервисов, сняты ограничения на общее количество выбранных DNS. Проверки работают потоком, одновременно максимум 8 сетевых задач. Updater проверяет версию, ожидаемый GitHub URL, размер, SHA-256, application ID и сертификат до открытия системного установщика.

## Проверенный метод GitHub публикации 2.1.0
История успешного run: https://github.com/Krenas/DNS-Connect/actions/runs/42395405220. Workflow скачал готовый APK из временного Release, сверил hash/size, прикрепил asset к публичному тегу v2.1.0, проверил asset и затем обновил latest.json. Это подтверждённый пример.

## Текущий binary publisher workflow
В public repo: .github/workflows/publish-uploaded-release.yml. Он слушает push ветки apk-upload/**. Ветка с тегом apk-upload/v2.3.0 должна содержать:
- incoming/release.json
- incoming/apk/000.b64, 001.b64, ... — отсортированные Base64 text chunks APK
- incoming/source/000.b64, 001.b64, ... — Base64 text chunks source ZIP

Workflow восстанавливает файлы, проверяет размеры/SHA-256, package/version/versionCode, signing fingerprint и source archive, импортирует source в main, создаёт Release, прикрепляет APK/source/SHA256SUMS и обновляет latest.json только после проверки release assets. Не считать публикацию завершённой, пока public endpoints не подтвердили assets и манифест.

## Подпись и первая установка
2.1.0 использовал другой сертификат. Переход с 2.1.0 на 2.3.0 требует backup export, uninstall, install новой версии, restore backup. Будущие релизы обязаны сохранять 2.2.x+ signing key. Ключ хранится в приватном DNS-Analytics/signing. Не публиковать JKS, Base64 keystore или password.

## Следующий обязательный шаг
В новом или текущем чате получить свежие 2.3.0 APK/source из Project Files и завершить перенос в public GitHub Release через workflow выше. После публикации проверить v2.3.0 assets с верными digest/size; source code в main; public latest.json version 2.3.0 / versionCode 24. Затем провести реальную проверку на устройстве. Каждый ответ завершать актуализацией checkpoint и Project Files.
