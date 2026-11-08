# DNS Connect — контрольная точка на 2026-11-08

## Проверенное состояние в этом чате
- Project Files: только `2.1.0.zip`, `Download Zip.zip`, `HB_AI_Xbox_DNS.exe`. APK/source ZIP 2.3.0 в Project Files нет.
- Library: поиск и полный просмотр текущего каталога не обнаружили артефакты 2.3.0. Попытка сохранить source ZIP 2.1.0 в Library вернула `library_storage_limit_exceeded`; существующие файлы не удалялись.
- Публичная ветка main: `48409545ab4b38d79b342e92b902747f248674d7` при первоначальной проверке. После исправления HANDOFF.md создан commit `190279a7ac631eff5bcc979007c0330f4f2212de`.
- В main отсутствует Android-проект (нет app/, settings.gradle.kts, app/build.gradle.kts).
- Releases: только дубликаты 2.1.0 с тегами `v2.1.0` и `2.1.0`; APK digest `c05e9cb8af2b4193ba2c77fb29bcb889e7588af4e61825af34c92af900c09755`, size 1,189,944.
- latest.json публично указывает на 2.1.0 / versionCode 22.
- 2.3.0 hashes ранее записаны, но файл и реальный build log недоступны. Нельзя публиковать 2.3.0 по этим строкам.
- Private signing repo есть; сертификат 2.2.x+ `4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90`. Не выводить keystore/password.
- Source ZIP, извлечённый из 2.1.0.zip: SHA-256 `4a762424e131333b90c424527f443f60b2a4d8659f016566ef09d5c9bba5a112`. APK 2.1 SHA-256 `c05e9cb8af2b4193ba2c77fb29bcb889e7588af4e61825af34c92af900c09755`.

## Как работал успешный Release 2.1.0
Успешный workflow run: https://github.com/Krenas/DNS-Connect/actions/runs/42395405220
Логи подтверждают: скачать готовый APK из staging Release с тегом 2.1.0 → SHA/size verify → загрузить его в canonical Release v2.1.0 → проверить digest/asset → обновить latest.json → проверить публичный raw manifest. Workflow не собирал APK из исходников.

## Workflow GitHub
- publish-uploaded-release.yml: временная ветка с Base64-decoded Git blobs *.part, publisher проверяет и публикует готовые APK/source; сборки нет и успешный запуск этой версии ещё не был проверен.
- build-release.yml: Gradle build из исходников, но ожидает приложение в main и четыре Actions secrets, которые не настроены.
- bootstrap-source.yml: импортирует уже опубликованный source ZIP/ APK из Release.
- Старые failed runs 42461667249–42462017764 не доказывают неисправность текущего publisher; они завершались без jobs.

## Новый чат / непрерывность
Пользователь не должен повторно загружать исходные Project Files или вручную переносить handoff. В новом чате внутри Project DNS найти и прочитать этот файл и HANDOFF.md, затем просмотреть Project Files/Library и GitHub. Всегда сверять реальные артефакты, не полагаться на ссылки/пути из прежних runtime. После каждого существенного действия обновлять оба документа.

## Следующие реальные шаги
1. Из 2.1 source + Project SDK archive восстановить реальный исходный проект в новом чате и аудитировать код.
2. Реализовать пользовательские изменения как настоящий source change, повысить versionCode; сохранить старый signing key 2.2.x+.
3. Выбрать один фактически работоспособный путь: локальная сборка и безопасный binary chunk publisher, либо GitHub Actions build при настройке Actions secrets.
4. Опубликовать Release только после реального APK/source assets с совпадающими hashes/sizes; затем обновить latest.json.
5. Верифицировать обнаружение, загрузку и проверку APK updater-кодом; Android installer requires user confirmation. Физическая установка на устройстве — NOT TESTED, пока не проведена.

## Ограничения проверки
В этом окружении не было установлено приложение на реальный телефон. DNS на Wi-Fi/mobile, Quick Settings/widgets и установка через PackageInstaller не тестировались на устройстве. PASS не присваивать таким тестам.
