# DNS Connect — постоянная точка продолжения

Обновлено: 2026-11-09. Это основной технический handoff проекта. Для нового чата сначала прочитать `NEXT-CHAT.md`, затем этот файл и `CHECKPOINT.md`.

## Проект и исходные данные

- Публичный репозиторий: https://github.com/Krenas/DNS-Connect
- Package: `ru.krenas.dnsanalytics`
- Название приложения: DNS Connect
- Текущая публичная версия: 2.1.0, versionCode 22.
- Цель следующей сборки: 2.3.0, versionCode 24.
- Базовый Project File: `2.1.0.zip` (внутри исходники `DNS-Connect-2.1.0-source.zip` и APK 2.1.0).
- Отдельная копия исходников: `DNS-Connect-2.1.0-source.zip`.
- SDK bundle: `Download Zip.zip`; в Project ранее также были отдельные platform-35/build-tools-35 ZIP.
- Windows reference: `HB_AI_Xbox_DNS.exe`.
- Новый чат создаётся внутри того же ChatGPT Project «DNS». Не просить пользователя повторно загружать эти файлы — найти их через Project Files.

## Постоянные ссылки

- [Репозиторий](https://github.com/Krenas/DNS-Connect)
- [Релизы](https://github.com/Krenas/DNS-Connect/releases)
- [Текущий latest.json](https://raw.githubusercontent.com/Krenas/DNS-Connect/main/latest.json)
- [NEXT-CHAT.md — точная инструкция для нового чата](https://github.com/Krenas/DNS-Connect/blob/main/NEXT-CHAT.md)
- [CHECKPOINT.md](https://github.com/Krenas/DNS-Connect/blob/main/CHECKPOINT.md)
- [Патч 2.3.0](https://github.com/Krenas/DNS-Connect/tree/main/bootstrap/patch-2.3.0)
- [Скрипт восстановления/сборки](https://github.com/Krenas/DNS-Connect/blob/main/bootstrap/rebuild-dns-connect-from-project-files.sh)
- [Настройки GitHub Actions secrets](https://github.com/Krenas/DNS-Connect/settings/secrets/actions)
- [Workflow сборки и публикации](https://github.com/Krenas/DNS-Connect/actions/workflows/build-from-archive.yml)
- [Workflow проверки подписывающих secrets](https://github.com/Krenas/DNS-Connect/actions/workflows/check-release-secrets.yml)

## Постоянный патч 2.3.0

Публичный каталог `bootstrap/patch-2.3.0/` содержит `manifest.json`, README и 13 частей `000.b64`–`012.b64`.

- Base64 payload: 38,132 bytes; SHA-256 `9a77468bebbe2b5b5e5f412a125f9dec160c5f9e85e2dbd4971388c7a93233ba`.
- Gzip payload: 28,598 bytes; SHA-256 `c08066e4be234e3405baa0dc0a563b3e5dce07036a81194846169807033c4f47`.
- Unified diff: 119,074 bytes; SHA-256 `0d2e4baaa30f1d336f32a6f92f293536f3b12498681f641d4870ff9c16a756d1`.
- Все 13 частей ранее и повторно проверялись Actions по длине и SHA-256: 13/13 PASS.
- В текущем чате база 2.1.0 была восстановлена, patch dry-run с `--fuzz=0` и применение прошли; идентичность результирующего исходного проекта: 2.3.0 / code 24 / package `ru.krenas.dnsanalytics`.
- Для восстановления использовать Project File `2.1.0.zip` + patch из GitHub; не начинать заново с исходников 1.8.0.

## Зафиксированные изменения 2.3.0

- First run выбирает все включённые DNS, не только первые три.
- Убраны произвольные лимиты количества DNS при комплексной проверке и сравнении; параллельность ограничена пулом задач, результаты поступают по мере завершения.
- Независимый выбор DNS-направлений/категорий и категорий сервисов.
- Разделение экранов настроек и меню.
- 20 цветов акцента, видимая заливка выбранной категории и расширенное применение темы.
- Исправлена нижняя системная панель в тёмной теме.
- Обновление проверяет URL, версию, package, SHA-256 и сертификат APK до передачи Android Installer. Установка всё равно требует системного подтверждения Android.

## Подпись и блокировка публикации

Сохранённый signing identity хранится только в приватном репозитории `Krenas/DNS-Analytics`, каталог `signing/`. Сертификат SHA-256:
`4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90`.

**В публичном workflow сейчас нужны ровно два secrets:**

1. `ANDROID_KEYSTORE_BASE64`
2. `ANDROID_KEYSTORE_PASSWORD`

Alias зафиксирован как `dnsconnect`; пароль ключа использует тот же пароль, что и JKS. Не использовать прежние инструкции о четырёх secrets: они устарели. Не публиковать JKS, пароль, Base64 ключа или их содержимое в репозитории, логах, handoff или исходном ZIP.

Последняя проверка secrets: workflow завершился штатно, но сообщил, что оба значения отсутствуют. GitHub connector в этой среде не предоставляет действия для создания/изменения repository Actions secrets. Поэтому не заявлять, что подпись облачной сборки уже настроена. Остающийся способ настройки — вручную добавить два значения в GitHub Settings → Secrets and variables → Actions.

## Сборка и QA

**Локальный кандидат 2.3.0 собран и проверен.**

Последняя локальная сборка выполнена из Project source 2.1.0 + основного патча + supplemental branding/UI patch, с SDK platform/build-tools 35 и сохранённым signing key 2.2.x.

- APK: `DNS-Connect-2.3.0-release.apk`, 1,202,232 bytes.
- APK SHA-256: `b376f8f15e6bcf815845bdb65bb6cd204703a5f9d21282b63a658f86d1407ff4`.
- Source ZIP: `DNS-Connect-2.3.0-source.zip`, 1,006,209 bytes.
- Source ZIP SHA-256: `6a2f58e6dda10a94963992c2ede9a2976a07c1d0a59e9a08b2873809b827ba0a`.
- Release pack: `DNS-Connect-2.3.0-release-pack.zip`, 1,972,455 bytes.
- Release pack SHA-256: `64c616533adcddc5b5d193cdce759057cd916bc77a7ad1128acc087b93bc8ad3`.
- Проверки: 108 self-tests PASS, 17 catalogue PASS, 141 UI/resource/navigation/theme/updater audit PASS; итого **266 PASS / 0 FAIL**.
- `tests/verify-icons.py`: PASS (24 glyph types).
- APK: apksigner v2/v3 PASS, zipalign PASS, package `ru.krenas.dnsanalytics`, version 2.3.0 / code 24.
- Source ZIP: unzip test PASS; safety audit PASS, signing material/passwords/unsafe paths not found.
- Clean reconstruct: оригинальный source ZIP 2.1.0 + main diff + supplemental diff применились с `--fuzz=0`.

**НЕ ПРОВЕРЕНО на физическом Android:** установка APK, доступ к реальным DNS/сервисам, виджеты, Quick Settings tile, скачивание APK обновления из приложения и системная установка. 266 автоматических PASS не означают, что физические проверки уже выполнены.

### Совместимость подписи — важное ограничение

- Публичный APK 2.1.0 подписан сертификатом SHA-256 `7767de2ba22670531c53ca6c76ea74e82c4d140f0907727644b2cd0864840c2b`.
- Новый APK 2.3.0 подписан сохранённым сертификатом 2.2.x SHA-256 `4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90`.
- Эти сертификаты разные. APK 2.3.0 нельзя установить поверх оставшегося 2.1.0 как обычное обновление Android. Для устройств на 2.2.x с сохранённым сертификатом обновление совместимо. Для 2.1.0 потребуется отдельная миграция/переустановка; пользовательские данные могут быть удалены. Не обещать seamless update с 2.1.0.

### Публикация

Это проверенный локальный кандидат, но **GitHub Release v2.3.0 ещё НЕ опубликован**. Public `latest.json` по-прежнему остаётся 2.1.0; не обновлять его, пока APK/source/checksums не будут загружены в Release и SHA/размеры не будут сверены.


## Иконка — итоговое состояние

- Существующая эмблема с тремя серверами находится в `app/src/main/res/drawable-nodpi/ic_dns_connect_foreground.png`: три серверных блока, глобус и щит DNS.
- Manifest `android:icon` и `android:roundIcon` направлены на regular/round adaptive launcher; все 4 adaptive XML (normal/API33+, regular/round) и верхний бренд-блок приложения используют этот же foreground.
- Android 13+ themed/monochrome icon раньше отличался старым рисунком с двумя рядами. Теперь он заменён на три серверных блока.
- Дополнительный патч `bootstrap/patch-2.3.0/branding-3server-monochrome.patch` включает также исправление теста UI, который проверял старый рисунок. Размер 3,710 bytes; SHA-256 `db74d35e8090a16dea74213703423d2073e2370da7dd3dbae79144c6c42e8362`.
- Rebuild script применяет его после основной diff и проверяет SHA, launcher links, toolbar brand icon и monochrome three-server geometry.
- Bottom-tab «Сервисы» в публичном APK 2.1.0 использует функциональный glyph `apps` (четыре квадрата); generic `server` glyph отображает два горизонтальных блока. Это не app logo. DNS Quick Settings tile и виджеты сохраняют функциональные glyphs, не подменяются логотипом.
- Последняя проверка patch CI: run `42588221283` SUCCESS; manifest candidate metadata was validated by run `42587917151` SUCCESS.


## Фактический статус GitHub на 2026-11-09

- Public main всё ещё содержит workflows, docs и patch bootstrap; Android Gradle source ещё не импортирован в корень.
- Public releases пока только дублируют версию 2.1.0. v2.3.0 не опубликован.
- Public `latest.json` остаётся 2.1.0 / code 22 / SHA-256 `c05e9cb8af2b4193ba2c77fb29bcb889e7588af4e61825af34c92af900c09755`.
- Build-from-archive workflow подготовлен, но cloud signing secrets отсутствуют.
- Required secrets: ровно `ANDROID_KEYSTORE_BASE64` и `ANDROID_KEYSTORE_PASSWORD`. Connector не предоставляет безопасного API для их создания. Не публиковать signing files в public repo.
- Запущен release candidate locally; APK/source/release-pack hashes приведены выше и в `bootstrap/patch-2.3.0/manifest.json`.
- После проверки workflow новых метаданных обновить manifest/handoff; затем ещё требуется загрузка assets и публикация release (через поддерживаемый GitHub upload path).



## Критические правила продолжения

1. Сначала прочитать `NEXT-CHAT.md`, `HANDOFF.md`, `CHECKPOINT.md`.
2. Сверить Project Files и реальный GitHub main/workflow/release status; не полагаться на старые локальные пути предыдущего runtime.
3. Не просить пользователя повторно загрузить уже имеющиеся Project Files.
4. Не публиковать подпись/пароль и не менять signing certificate без осознанной причины.
5. Не заявлять об опубликованном 2.3.0, рабочем автообновлении или физическом тесте, пока это не подтверждено реальными данными.
6. После каждого существенного действия обновлять этот handoff и checkpoint.
