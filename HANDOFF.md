# DNS Connect — постоянная точка продолжения

Обновлено: 2026-11-08. Этот файл — источник правды для нового чата. Всегда перечитать его и CHECKPOINT.md до изменения файлов или выпуска APK.

## Обязательное правило передачи между чатами
Пользователь не должен повторно прикреплять имеющиеся файлы и не должен копировать длинные handoff-тексты. Каждое содержательное сообщение может оказаться последним в чате: после каждого существенного изменения обновлять этот файл и CHECKPOINT.md. Сохранять только реально существующие и проверенные артефакты. В новом чате внутри того же ChatGPT Project «DNS» сначала просмотреть Project Files и Library, затем прочитать актуальные HANDOFF.md и CHECKPOINT.md здесь. Не спрашивать пользователя повторно о том, что уже известно. Если файл недоступен — честно указать конкретную причину и использовать последнюю проверенную копию из публичного/приватного GitHub.

## Постоянные адреса
- Публичный репозиторий: https://github.com/Krenas/DNS-Connect
- Releases: https://github.com/Krenas/DNS-Connect/releases
- Манифест обновлений: https://raw.githubusercontent.com/Krenas/DNS-Connect/main/latest.json
- Контрольная точка: https://github.com/Krenas/DNS-Connect/blob/main/CHECKPOINT.md
- История задач: https://github.com/Krenas/DNS-Connect/blob/main/CHANGELOG.md
- Приватное хранилище подписи: https://github.com/Krenas/DNS-Analytics/tree/main/signing
- Проверенный пример публикации 2.1.0: https://github.com/Krenas/DNS-Connect/actions/runs/42395405220

## Реально доступные исходные файлы в Project Files на 2026-11-08
- `2.1.0.zip` — исходный архив/сборка базовой версии; file_id `file_00000000b52c8210b3f9387cf7fd5984`.
- `Download Zip.zip` — Android build tooling (SDK platform 35, build-tools 35, Gradle 8.11.1, platform-tools); file_id `file_00000000f5148243aa1e27323fc146ed`.
- `HB_AI_Xbox_DNS.exe` — старый Windows executable; file_id `file_0000000094588210a0b26730033ee76e`.
В обычном списке Project Files нет APK или source ZIP 2.3.0. В доступном Library также не найдено ни одного артефакта 2.3.0. Загрузка копии source ZIP 2.1.0 в Library не удалась из-за достигнутого лимита хранилища Library. Не утверждать, что 2.3.0 файлы лежат в Project Files, Library или локальном runtime — это не так в новом окружении.

## Публичный GitHub — проверенное состояние
- Ветка main: `48409545ab4b38d79b342e92b902747f248674d7`.
- В main сейчас только workflow/README/HANDOFF/CHECKPOINT/CHANGELOG/SHA256SUMS/latest.json. Папок `app/`, Android Gradle проекта и `settings.gradle.kts` нет.
- Доступны только два публичных Release 2.1.0: с тегами `v2.1.0` и `2.1.0`. Никакого опубликованного Release 2.2.0 или 2.3.0 нет.
- `latest.json` по-прежнему указывает на version 2.1.0, versionCode 22, APK SHA-256 `c05e9cb8af2b4193ba2c77fb29bcb889e7588af4e61825af34c92af900c09755`, size 1,189,944.
- Канонический APK URL: https://github.com/Krenas/DNS-Connect/releases/download/v2.1.0/DNS-Connect-2.1.0-release.apk

## 2.3.0 — статус без предположений
Ранее в handoff были записаны кандидат 2.3.0 / versionCode 24 и хэши APK `852c7c744b96dd5e855cdd4a039f4d092cdf00128e60dc5325e5b46f203d839d` и source ZIP `b16cc38d657ea4ce8e8690dc060070dfbac6d086f80b7e757bc52e211118068f`. Однако сами соответствующие файлы, логи сборки и release pack не доступны в текущем Project Files, Library или рабочем runtime. Поэтому эти хэши — только прежние записи, а не независимо перепроверенные артефакты. Не публиковать и не заявлять релиз 2.3.0 на основании одних строк SHA или предыдущего ответа. Сначала восстановить реальные исходники; версия 2.1.0 — единственная воспроизводимая база в Project Files.

## Реально проверенная схема публикации 2.1.0
Успешный Actions run https://github.com/Krenas/DNS-Connect/actions/runs/42395405220 был НЕ сборкой APK из исходников. Шаги:
1. APK уже был загружен в предварительный Release с тегом `2.1.0`.
2. Workflow скачал `DNS-Connect-2.1.0-release.apk` с помощью `gh release download 2.1.0`.
3. Проверил SHA-256 и точный размер.
4. Прикрепил APK к каноническому Release с тегом `v2.1.0` через `gh release upload v2.1.0 ... --clobber`.
5. Проверил опубликованный asset digest, size, URL и статус Release.
6. Только затем записал `latest.json` через GitHub Contents API и дождался доступности публичного raw-файла.
Это подтверждено логами job 128471582881. Так работает доставка существующего APK в Release; это не способ получить APK из исходников.

## Workflow, находящиеся в публичном репозитории
- `.github/workflows/publish-uploaded-release.yml`: принимает заранее собранные APK/source как двоичные .part blobs на временной ветке `apk-upload/<tag>`, проверяет размеры, хэши, package/version/code/certificate/source ZIP, создаёт Release и обновляет latest.json. Реального запуска этой версии workflow ещё нет. Он НЕ компилирует APK.
- `.github/workflows/build-release.yml`: Gradle builder из Android исходников, но требует исходный проект уже в main и GitHub Actions secrets `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_ALIAS`, `ANDROID_KEY_PASSWORD`. Папки app нет и секреты не настроены. Этот workflow пока НЕ готов к запуску.
- `.github/workflows/bootstrap-source.yml`: импортирует уже опубликованный source ZIP и проверенный APK из Release, которого для 2.3 пока нет.
Старые неудачные workflow runs с ID 42461667249–42462017764 завершались без jobs; текущий новый publisher ими не проверен.

## Доступная реальная исходная база 2.1.0
Из `2.1.0.zip` извлечён source ZIP:
- SHA-256: `4a762424e131333b90c424527f443f60b2a4d8659f016566ef09d5c9bba5a112`.
- APK 2.1.0 SHA-256: `c05e9cb8af2b4193ba2c77fb29bcb889e7588af4e61825af34c92af900c09755`.
- Package: `ru.krenas.dnsanalytics`; versionCode 22; versionName 2.1.0; minSdk 26; targetSdk 35.
- Source contains native Android Java app, Gradle wrapper, `build-local.sh`, tests and `GitHubUpdateManager.java`.
- `GitHubUpdateManager.java` reads public latest.json, validates exact GitHub release URL, hash, size, package and signer, downloads APK and opens Android installer. Android requires the user to confirm installation.
- В UI есть кнопка `Быстрый набор · 3 DNS`; это quick-preset на три записи. Не считать это доказательством наличия общего лимита выбора, не проверив все handlers и selection logic.
- Этот 2.1 исходный код не содержит заявленных прошлым handoff четырёх build scripts `prepare-android-sdk.sh`, `build-local.sh`, `package-release.sh`, `build-from-project-files.sh`; реально присутствует только `build-local.sh`.

## Подпись и миграция
Постоянный сертификат 2.2.x+ SHA-256: `4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90`; alias `dnsconnect`. Ключ хранится в приватном `Krenas/DNS-Analytics/signing`; никогда не помещать его в публичный репозиторий/source ZIP и не выводить пароль в чат/логи. В репозитории 2.1.0 использовался иной сертификат. Переход с 2.1.0 требует backup → uninstall old → install new → restore. Все будущие APK обязаны использовать один и тот же сохранённый ключ.

## Архитектура дальнейшей работы
При каждом новом чате:
1. Перечитать этот handoff и CHECKPOINT.
2. Проверить Project Files и Library, затем public main/latest.json/releases и private signing repo.
3. Не просить повторный upload Project Files. При отсутствии 2.3 исходников использовать доступную базу 2.1.0 и действительно реализовывать изменения с инкрементом versionCode; не маркировать старую сборку как 2.3.
4. Для стабильной публикации использовать локальную сборку с сохранённым ключом + безопасную передачу prebuilt APK/source в GitHub publisher (через временные Git blob chunks), если бинарная передача доступна. Альтернативно — наладить source-archive → GitHub Actions Gradle build, но для него нужно безопасно настроить Actions secrets один раз. Не помещать signing key в public repo.
5. До подтверждения проверять: Release published, APK asset SHA/size, source asset SHA/ZIP, latest.json публично доступен и совпадает, imported source main содержит app/build.gradle.kts/manifest, updater видит более новую version; тест установки возможен только на реальном Android.
6. После каждого существенного действия фиксировать реальное состояние в HANDOFF.md и CHECKPOINT.md. В конце отвечать точно: что реально работает, что пока блокирует, что пользователь должен сделать (если что-либо).

## Что физически не тестируется удалённо
Установка/обновление на телефоне, реальное разрешение DNS Wi-Fi/мобильной сети, runtime widgets/Quick Settings, поведение системного installer требуют Android устройства. Не ставить PASS без физического прогона.
