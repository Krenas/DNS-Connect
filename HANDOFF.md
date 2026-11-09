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





## Дополнительно найденные входные файлы проекта (2026-11-08)
- Отдельный Project-generated `DNS-Connect-2.1.0-source.zip`, file_id `file_000000000d148210a4c2ab19680a94fc`, размер 981,497 bytes — можно использовать напрямую вместо извлечения из outer `2.1.0.zip`.
- Project-generated `platform-35.zip`, file_id `file_0000000032f082108d7228e22e470a95`, размер 64,273,788 bytes.
- Project-generated `build-tools-35.zip`, file_id `file_000000005330821085260905fcfacb97`, размер 61,958,799 bytes.
- Full `Download Zip.zip` имеет 425,160,739 bytes и превышает 100 MiB raw-materialize limit текущего Files connector. Использовать отдельные platform/build-tools Project files, если full SDK bundle невозможно материализовать; корректную сборочную компоновку SDK подтвердить отдельным build/test, не считать эти два ZIP автоматически готовым SDK root.
- Private repo `Krenas/DNS-Analytics` содержит app source 1.8.0 и старые ZIP, но не содержит 2.1.0 app tree. Для 2.3.0 использовать Project 2.1.0 source ZIP + public verified patch, не откатываться к 1.8.0.



## Автоматическая схема «source ZIP → APK → GitHub Release» (2026-11-08)
- Создан `.github/workflows/build-from-archive.yml`. Trigger: commit/push ZIP `incoming/DNS-Connect-*-source.zip` в `main`; доступен и `workflow_dispatch` для уже commit-нутого ZIP.
- Workflow проверяет безопасность путей ZIP, запрещает symlink, вложенные JKS/keystore/password-файлы, проверяет Gradle project identity/version/versionCode, устанавливает Java 17 и Android SDK platform 35/build-tools 35, прогоняет тесты, строит signed APK, сверяет package/version/versionCode/certificate SHA-256/zipalign, пакует clean source ZIP и checksums, создаёт GitHub Release, проверяет asset digest и size, публикует Release и обновляет публичный `latest.json`. Для push-trigger исходный ZIP удаляется после успешного выполнения с `[skip ci]`.
- Инструкция по drop-zone: `incoming/README.md`. Публичный README тоже обновлён.
- Это и есть предполагаемая схема из описания пользователя: помощник один раз коммитит собранный source ZIP в `incoming/`; Actions сам собирает APK и публикует его, приложение читает `latest.json`. В следующих релизах помощнику не нужно локально строить/подписывать APK — только подготовить source ZIP и положить его в папку.
- Один раз должны существовать repository Actions secrets (Settings → Secrets and variables → Actions): `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_ALIAS=dnsconnect`, `ANDROID_KEY_PASSWORD`. Workflow останавливается, если секреты отсутствуют. Значения JKS/password никогда не размещать в public repo/source archive/logs. Инструкция: https://github.com/Krenas/DNS-Connect/settings/secrets/actions.
- Общий lint/test workflow обновлён: `.github/workflows/verify-patch-payload.yml` запускает actionlint для всех workflow при изменении workflow-файлов, затем проверяет patch payload. Успешный run: https://github.com/Krenas/DNS-Connect/actions/runs/42500505393 — actionlint SUCCESS и 13/13 патч-фрагментов PASS.
- Был один ранний lint run, стартовавший одновременно до исправления SC2129 shellcheck warnings в двух workflows; он упал. После группировки GITHUB_ENV writes более новый run прошёл полностью. При дальнейшей проверке ориентироваться на последний successful main run.
- Публичный Release 2.3.0 всё ещё НЕ опубликован, а latest.json остаётся 2.1.0. ZIP 2.3.0 ещё не помещён в `incoming/`, потому что текущий runtime не предоставил работающее локальное shell/Python выполнение для создания/передачи source ZIP. Поэтому Actions сборка пока не запускалась на реальном архиве.





## Проверка истории GitHub на сохранённые 2.3.0 assets
- Перечислены все доступные ветки: `main` и пять временных `patch-verify/*` веток. Ветка `apk-upload/*` и архив с исходниками 2.3.0 в истории не обнаружены.
- Проверены старые Actions runs от 2026-11-08 по публикации uploaded APK: они завершались failure и не оставили workflow artifacts. Единственный пригодный артефакт предыдущих успешных прогонов — проверенный patch bundle, не APK/source ZIP.
- Следовательно, требуется создать clean source ZIP из Project base 2.1.0 + постоянного patch, затем commit в `incoming/`. Локальное создание/передача source ZIP остаётся единственным текущим техническим блокером до запуска нового build workflow.

## Дополнительная сверка Library (2026-11-08)
- Повторно просмотрен весь доступный Project Library. В папке DNS нет APK/source ZIP 2.3.0; присутствуют старые checksum/signing metadata, не пригодные как release binary. Переиспользовать артефакты 2.3.0 из Library не удалось.
- Следующий чат не должен делать вид, что APK/source уже находятся в Library. Входные исходники находятся в Project Files, а patch — в публичном GitHub.

## Обязательная фиксация прогресса для короткоживущих чатов
- Не ждать конца чата: перед каждым большим/рискованным этапом обновить CHECKPOINT с текущим состоянием и ближайшей операцией; после каждого завершённого этапа записать фактический результат, ссылки, hashes, PASS/FAIL/NOT TESTED.
- Перед любым релизным изменением сверять main/Release/latest.json. Не публиковать latest.json до подтверждённой загрузки APK и source assets.
- Если локальный runtime/лимит перестал работать, не терять достигнутое: зафиксировать конкретный недоделанный шаг в обеих точках продолжения и оставить новые файлы в GitHub.

## Проверка патча GitHub Actions (2026-11-08)
- Добавлен строгий workflow `.github/workflows/verify-patch-payload.yml`: он проверяет длину и SHA-256 каждой из 13 частей, общий Base64 payload, gzip payload и распакованный unified diff по значениям из `manifest.json`, затем проверяет, что Git может разобрать patch.
- Успешный строгий run: https://github.com/Krenas/DNS-Connect/actions/runs/42499262769 — 13/13 chunk PASS; общий payload, gzip и diff SHA/size PASS; artifact создан.
- Успешный предварительный run с подробным numstat: https://github.com/Krenas/DNS-Connect/actions/runs/42498883523.
- Workflow с усиленными проверками зафиксирован в main commit `5a6a4754b9bc623f5378ca62acadcf8b546485fa`. Это подтверждает сохранность patch-файлов, но не заменяет сборку Android APK и не является Release.

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


## Проверка signing secrets (2026-11-08)
- Добавлен безопасный workflow `.github/workflows/check-release-secrets.yml`, выводит только имена отсутствующих secrets и никогда их значения.
- Run: https://github.com/Krenas/DNS-Connect/actions/runs/42501222010 — SUCCESS; отсутствуют все 4: `ANDROID_KEYSTORE_BASE64`, `ANDROID_KEYSTORE_PASSWORD`, `ANDROID_KEY_ALIAS`, `ANDROID_KEY_PASSWORD`.
- Workflow fixed after a ShellCheck SC2016 finding in the Markdown summary. Latest all-workflow actionlint + patch integrity run: https://github.com/Krenas/DNS-Connect/actions/runs/42501298298 — SUCCESS (actionlint all workflows, 13/13 chunk files, Base64/gzip/diff checksum validation).
- One-time settings URL: https://github.com/Krenas/DNS-Connect/settings/secrets/actions. User/admin must create four secrets using existing private JKS and credentials. Do not put values into chat, public files, commits or logs.


## Новая контрольная точка — 2026-11-08, продолжение
- В текущей сессии сверены публичные Releases и latest.json: по-прежнему опубликован только 2.1.0 (два одинаковых тега); публичный updater manifest не переведён на 2.3.0.
- GitHub main содержит build-from-archive workflow, drop-zone incoming/ и 13 частей проверенного patch 2.3.0. Успешный последний lint/integrity run: https://github.com/Krenas/DNS-Connect/actions/runs/42501298298 (SUCCESS).
- Повторная материализация Project Files прошла успешно: DNS-Connect-2.1.0-source.zip (981,497 bytes), platform-35.zip (64,273,788 bytes), build-tools-35.zip (61,958,799 bytes) доступны по путям /mnt/data/dnsconnect-project-inputs/.
- Попытка обработать эти файлы блокируется недоступностью локального runtime (container/Python ClientError). Дополнительно инструмент Python/data analysis сообщил о временном лимите; оценка восстановления — около 20 часов 26 минут, не гарантия. Не запускать другой исполнитель для обхода этого лимита.
- Поэтому исходный ZIP 2.3.0 ещё не создан и не загружен в incoming; build-from-archive.yml не запускался на реальном архиве. APK 2.3.0 не опубликован, latest.json не обновлялся, live in-app update не проверен.
- Репозиторий всё ещё не имеет четырёх требуемых protected Actions secrets: ANDROID_KEYSTORE_BASE64, ANDROID_KEYSTORE_PASSWORD, ANDROID_KEY_ALIAS, ANDROID_KEY_PASSWORD. Один раз добавить их владелец может здесь: https://github.com/Krenas/DNS-Connect/settings/secrets/actions. Значение alias — dnsconnect; не передавать ключ/пароли в чат или public repo.
- Не просить повторную загрузку исходных файлов. После восстановления разрешённого файлового runtime: распаковать source 2.1.0, проверить патч hashes из manifest, применить без fuzz, проверить Gradle identity (ru.krenas.dnsanalytics / 2.3.0 / code 24), создать clean ZIP и закоммитить его в incoming/. После этого Actions build/release, проверить assets/SHA/size, latest.json и updater. Physical Android installer — NOT TESTED до проверки на телефоне.


## Повторная проверка и состояние продолжения — 2026-11-08, поздний запуск
- Повторно проверены public repo metadata, main-файлы, latest.json и Releases. Репозиторий публичный; доступ текущего GitHub connection: admin/push. В main всё ещё нет app Gradle tree (app/build.gradle.kts и app/src/main/AndroidManifest.xml возвращают 404); импорт исходников 2.3.0 не выполнялся.
- latest.json по-прежнему публикует 2.1.0 / versionCode 22 / APK SHA-256 c05e9cb8af2b4193ba2c77fb29bcb889e7588af4e61825af34c92af900c09755. Releases содержат только v2.1.0 и 2.1.0; каждый имеет единственный APK asset 1,189,944 bytes с тем же digest. Release 2.3.0 отсутствует.
- Последний workflow verification run https://github.com/Krenas/DNS-Connect/actions/runs/42501298298: completed/success; actionlint для всех YAML workflow + проверка 13 patch chunks/payload прошли. Этот run не собирал Android APK.
- Safe signing check run https://github.com/Krenas/DNS-Connect/actions/runs/42501222010: completed/success, но все четыре repository Actions secrets отсутствуют: ANDROID_KEYSTORE_BASE64, ANDROID_KEYSTORE_PASSWORD, ANDROID_KEY_ALIAS, ANDROID_KEY_PASSWORD.
- Подтверждена сохранность 2.2.x signer metadata в private Krenas/DNS-Analytics: signing/DNS-Connect-2.2.0-signing-key.jks, signing/DNS-Connect-2.2.0-signing-password.base64.txt, alias dnsconnect, certificate SHA-256 4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90. README подтверждает, что это continuity key для последующих совместимых обновлений. Содержимое пароля не считывалось и не выводилось. Никакие signing files не копировать в public repo.
- GitHub Actions secrets REST API требует отдельного credential с Secrets: write и шифрование значений на стороне клиента; текущий набор GitHub actions не предоставляет create/update repository secret. Это реальное ограничение текущих полномочий/инструментов, а не ошибка сборочного YAML. Одноразовая страница настройки: https://github.com/Krenas/DNS-Connect/settings/secrets/actions.
- Project Files успешно повторно материализованы в текущем сеансе: DNS-Connect-2.1.0-source.zip (file_id file_000000000d148210a4c2ab19680a94fc; 981,497 bytes), 2.1.0.zip (file_id file_00000000b52c8210b3f9387cf7fd5984; 5,408,409 bytes), platform-35.zip (file_id file_0000000032f082108d7228e22e470a95; 64,273,788 bytes), build-tools-35.zip (file_id file_000000005330821085260905fcfacb97; 61,958,799 bytes). Повторная загрузка от пользователя не нужна.
- Файловая операция создания source ZIP 2.3.0 в этом сеансе не завершилась: локальное исполнение вернуло ошибку, а функция анализа данных/Python затем сообщила о временной недоступности. Патч НЕ применён в этом сеансе; новый ZIP НЕ создан; binary не загружен в incoming. Не заявлять иначе.
- .github/workflows/build-from-archive.yml детально просмотрен: ожидает incoming/DNS-Connect-*-source.zip, app/build.gradle.kts, settings.gradle.kts, gradle wrapper, package ru.krenas.dnsanalytics и versionCode выше latest; использует четыре ANDROID_* secrets, собирает Java 17 / Android SDK 35, проверяет certificate SHA-256 и zipalign, создаёт Release assets и только затем обновляет latest.json. Workflow прошёл lint, но реальный run на входном ZIP НЕ выполнялся.
- Точный следующий шаг: восстановить clean DNS-Connect-2.3.0-source.zip из Project source 2.1.0 + bootstrap/patch-2.3.0; добавить ZIP в incoming/ (не добавляя ключи); дождаться фактического workflow build; настроить четыре защищённых Actions secrets через GitHub settings/API; проверить release assets/digests и public latest.json; затем тестировать in-app update. Физическая установка через Android Package Installer остаётся NOT TESTED до проверки на телефоне.


## Актуальное состояние на 2026-11-09 (перекрывает старые сведения о подписи выше)
- Сборочные workflows build-from-archive.yml и build-release.yml обновлены: теперь требуют только два protected Actions secrets — ANDROID_KEYSTORE_BASE64 и ANDROID_KEYSTORE_PASSWORD. Alias dnsconnect фиксирован внутри workflow; пароль ключа берётся из ANDROID_KEYSTORE_PASSWORD. Старые упоминания четырёх secrets выше — исторические и больше не актуальны.
- README.md обновлён под схему с двумя secrets. Последний signing-check run 42567301201 SUCCESS по коду workflow, но сообщает, что оба секрета пока отсутствуют: ANDROID_KEYSTORE_BASE64 и ANDROID_KEYSTORE_PASSWORD. Настройки: https://github.com/Krenas/DNS-Connect/settings/secrets/actions.
- Последние проверки GitHub Actions на main: run 42567340994 SUCCESS (actionlint для всех workflow + 13/13 chunks + aggregate Base64/gzip/diff checksum), run 42567301113 SUCCESS (предыдущее состояние workflows + patch check).
- Main до сих пор не содержит app Gradle source tree; latest.json по-прежнему указывает на 2.1.0; публичного Release 2.3.0 нет. Публиковать manifest раньше подтверждённого APK запрещено.
- Отдельный аудит 2.3.0 patch через workflow 42567150343: patch изменяет Java/build/test файлы, включая GitHubUpdateManager.java и MainActivity.java, но не изменяет res/assets/drawable/mipmap/launcher/icon files. Поэтому требование пользователя поставить существующую иконку раздела «Сервисы» с тремя серверами как launcher/app icon и заменить все брендовые иконки ещё не выполнено.
- Физическая проверка Android и live update installer остаются NOT TESTED. Кандидатные статические проверки 266 PASS / 0 FAIL из предыдущего runtime не являются доказательством установки/обновления на телефоне.
- Следующие блокеры: добавить два secrets через Settings; получить/собрать source ZIP 2.3.0 из Project 2.1.0 source + checked-in patch; включить в source icon resource change только после нахождения точного трехсерверного значка из раздела «Сервисы»; build and publish Release v2.3.0 with cert SHA 4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90; verify latest.json/assets; test on physical Android.


## Последняя проверка после изменений CI — 2026-11-09
- Добавлен workflow_dispatch в check-release-secrets.yml, чтобы владелец мог вручную повторить безопасную проверку после заполнения секретов.
- Signing check run 42567494139: workflow SUCCESS, результат — оба секрета отсутствуют: ANDROID_KEYSTORE_BASE64 и ANDROID_KEYSTORE_PASSWORD.
- Последний regression/lint run 42567494192: SUCCESS на commit 1cc6907b1f98a7cfeeafb48493d9c73702cc2a6d. Шаги actionlint, fragment verification, aggregate Base64/gzip/diff verification и artifact upload — все SUCCESS.
- Для ручной повторной проверки: https://github.com/Krenas/DNS-Connect/actions/workflows/check-release-secrets.yml. Для настройки: https://github.com/Krenas/DNS-Connect/settings/secrets/actions.
