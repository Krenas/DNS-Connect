# DNS Connect — постоянная точка продолжения
Обновлено: 2026-11-08. Этот файл и CHECKPOINT.md — долговременный handoff. Новый чат начинает с них, а не просит пользователя загружать файлы повторно.

## Правило непрерывности
Пользователь не обязан повторно прикреплять Project Files, APK, архивы или копировать длинные handoff-тексты. Любое сообщение может быть последним: после каждого существенного действия обновлять HANDOFF.md и CHECKPOINT.md, фиксировать реальный GitHub-статус и хранить только проверенные сведения. Новый чат создаётся внутри существующего ChatGPT Project «DNS» и самостоятельно находит Project Files и публичный handoff.

## Постоянные ссылки
- Репозиторий: https://github.com/Krenas/DNS-Connect
- Releases: https://github.com/Krenas/DNS-Connect/releases
- Манифест: https://raw.githubusercontent.com/Krenas/DNS-Connect/main/latest.json
- CHECKPOINT: https://github.com/Krenas/DNS-Connect/blob/main/CHECKPOINT.md
- Патч 2.3.0: https://github.com/Krenas/DNS-Connect/tree/main/bootstrap/patch-2.3.0
- Rebuild driver: https://github.com/Krenas/DNS-Connect/blob/main/bootstrap/rebuild-dns-connect-from-project-files.sh
- Приватный signer: https://github.com/Krenas/DNS-Analytics/tree/main/signing
- Успешная публикация 2.1.0: https://github.com/Krenas/DNS-Connect/actions/runs/42395405220

## Неизменяемые Project Files — входы каждого нового чата
- 2.1.0.zip (file_id file_00000000b52c8210b3f9387cf7fd5984): внутри DNS-Connect-2.1.0-source.zip и APK 2.1.0.
- Download Zip.zip (file_id file_00000000f5148243aa1e27323fc146ed): Android SDK tooling, platform 35 и build-tools 35.
- HB_AI_Xbox_DNS.exe (file_id file_0000000094588210a0b26730033ee76e): исходный Windows executable/reference.
Новые архивы у пользователя просить не нужно. APK/source ZIP 2.3.0 в Project Files не сохранены из-за лимита Library storage, но 2.3.0 полностью восстанавливается из 2.1.0.zip и постоянного GitHub-патча.

## Постоянный патч 2.3.0
В bootstrap/patch-2.3.0 находятся README.md, manifest.json и 13 частей 000.b64–012.b64. Все части повторно скачаны с GitHub и сверены по длине/SHA-256: 13/13 PASS. Патч применяется к исходному 2.1.0 source ZIP без fuzz.
- Base64 payload: 38,132 bytes; SHA-256 9a77468bebbe2b5b5e5f412a125f9dec160c5f9e85e2dbd4971388c7a93233ba.
- Gzip payload: 28,598 bytes; SHA-256 c08066e4be234e3405baa0dc0a563b3e5dce07036a81194846169807033c4f47.
- Unified diff: 119,074 bytes; SHA-256 0d2e4baaa30f1d336f32a6f92f293536f3b12498681f641d4870ff9c16a756d1.
- Чистое применение патча к исходникам 2.1.0 и проверка package/version/code прошли.

## Сборка без повторной загрузки файлов
Один entry point: bootstrap/rebuild-dns-connect-from-project-files.sh. Он извлекает source ZIP из Project 2.1.0.zip, получает/принимает cache патча, проверяет SHA каждого фрагмента и всего патча, декомпрессирует и применяет его с нулевым fuzz, проверяет версию 2.3.0/code 24/package ru.krenas.dnsanalytics, собирает source ZIP, подготавливает platform 35/build-tools 35 из Download Zip.zip, запускает Java compile, DEX, тесты, zipalign, APK v2/v3 signing и создаёт Release Pack.
Входы: пути к Project 2.1.0.zip и Download Zip.zip плюс постоянный JKS из приватного Krenas/DNS-Analytics/signing. Пароль — только в переменной среды DNS_RELEASE_KEYSTORE_PASSWORD; не выводить его и не помещать в публичный репозиторий/source archive/logs. Rebuild driver автоматически получает raw chunks, если сеть доступна; иначе новый чат должен fetch-нуть 13 частей через GitHub connector и передать каталог cache.
Важно: JKS и пароль никогда не добавлять в публичный репозиторий/source ZIP.

## Проверенный кандидат 2.3.0 — текущие артефакты локального runtime
- package ru.krenas.dnsanalytics; versionName 2.3.0; versionCode 24; minSdk 26; targetSdk 35.
- APK 1,202,232 bytes; SHA-256 9cc3bb050e4efd9fa74d161e4f2e2ec6e034b8f9ec2095f79233c178aaa1bc56.
- Source ZIP 1,006,206 bytes; SHA-256 cb3f80e694d81fe8b615e374260b9b2e5ffdb759660ad8e4d160bdb2c982edc2.
- Release pack SHA-256 43c6ddaf71e79fd631222d19b85e101810debf8b3158b3cfe8ff45f27b29c13b.
- Certificate SHA-256 4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90.
- Self tests 108 PASS/0 FAIL; catalogue 17 PASS/0 FAIL; UI/resource/navigation/theme/updater audit 141 PASS/0 FAIL. Total 266 PASS/0 FAIL. APK Signature v2/v3 PASS; zipalign PASS.
- Physical Android device, live Wi-Fi/mobile DNS, widgets/Quick Settings runtime, live updater download/install: NOT TESTED.
Эти APK/source ZIP/QA/log существуют в текущем runtime, но не закреплены в Project Files. Новый чат должен rebuild-нуть из Project Files + GitHub patch, если sandbox paths не сохранились.

## Изменения 2.3.0
- First-run выбирает все включённые DNS, а не первые три.
- Нет суммарного лимита выбора DNS в комплексной проверке/сравнении; одновременно выполняется максимум восемь сетевых задач, результаты поступают по мере завершения.
- Независимое включение DNS-категорий и сервисов.
- Настройки и меню разделены на самостоятельные экраны.
- 20 цветов акцента, заливка выбранной категории и более полное распространение акцентной темы.
- Исправлена нижняя системная панель в тёмной теме.
- Обновления проверяют URL, версию, package, SHA-256 и сертификат до передачи APK системному installer. Android всё равно требует подтверждения установки.

## Реальный GitHub-релизный статус
Публичный main содержит документацию, workflow и постоянный патч, но пока не содержит app Gradle project. Опубликованы только два дубликата Release 2.1.0 (теги v2.1.0 и 2.1.0). latest.json всё ещё указывает на 2.1.0 / versionCode 22 / SHA-256 c05e9cb8af2b4193ba2c77fb29bcb889e7588af4e61825af34c92af900c09755. Release v2.3.0 НЕ опубликован, поэтому установленный updater пока не обнаружит 2.3.0.
publish-uploaded-release.yml публикует заранее собранные двоичные Git blobs; сам APK он не компилирует. build-release.yml может собирать Gradle-проект из main, но ожидает уже импортированные app sources и четыре Actions secrets: ANDROID_KEYSTORE_BASE64, ANDROID_KEYSTORE_PASSWORD, ANDROID_KEY_ALIAS, ANDROID_KEY_PASSWORD. Секреты не настроены. Доступные GitHub connector actions не предоставляют прямую загрузку Release assets или управление Actions secrets. Ничего из этого не заявлять готовым без фактической проверки.
Успешная схема релиза 2.1.0: staging Release tag 2.1.0 уже содержит APK; workflow скачивает asset, проверяет SHA/размер, прикрепляет к v2.1.0, сверяет digest, обновляет latest.json. Это подтверждено run 42395405220; workflow не строил APK из исходников.

## Подпись и первая миграция
Alias dnsconnect; сертификат SHA-256 4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90. JKS/пароль находятся только в private DNS-Analytics/signing. 2.1.0 подписан другим сертификатом: первая миграция требует backup → uninstall 2.1.0 → install 2.3.0 → restore. Все последующие версии должны использовать этот постоянный signer. Android installer требует подтверждения пользователя.

## Протокол каждого нового чата
1. Прочитать HANDOFF.md и CHECKPOINT.md.
2. Проверить Project Files и public GitHub state.
3. Если runtime artifacts отсутствуют, rebuild-нуть 2.3.0 из 2.1.0.zip + Download Zip.zip через permanent patch и signer.
4. Не просить повторную загрузку файлов.
5. Не смешивать локальную сборку с фактом публичной публикации.
6. Перед заявлением о готовности проверить public Release assets/digests/sizes, app sources в main, latest.json и логику updater. Установка на реальном телефоне остаётся NOT TESTED, пока её реально не выполнят.
7. После каждого существенного действия обновлять HANDOFF.md и CHECKPOINT.md.
