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

Зафиксированный кандидат предыдущей локальной сборки 2.3.0 (артефакты не закреплены в Project Files текущего чата):
- APK: 1,202,232 bytes; SHA-256 `9cc3bb050e4efd9fa74d161e4f2e2ec6e034b8f9ec2095f79233c178aaa1bc56`.
- Source ZIP: 1,006,206 bytes; SHA-256 `cb3f80e694d81fe8b615e374260b9b2e5ffdb759660ad8e4d160bdb2c982edc2`.
- Release pack SHA-256 `43c6ddaf71e79fd631222d19b85e101810debf8b3158b3cfe8ff45f27b29c13b`.
- Ранее записанный автоматический результат: self-tests 108 PASS, каталог 17 PASS, UI/resource/navigation/theme/updater audit 141 PASS — всего 266 PASS / 0 FAIL. APK signature v2/v3 и zipalign — PASS.
- В текущем продолжении также были повторно заявлены PASS для patch apply, UI audit, catalogue (17/17) и glyph/resource tests.
- Физический Android, реальная Wi-Fi/mobile сеть, live DNS, Quick Settings, виджеты, фактическое скачивание и установка обновления через приложение — NOT TESTED.

Не обещать «ошибок больше нет»: автоматические проверки не заменяют тест на устройстве и проверку реальной сети.

## Иконка — брендинг найден, патч добавлен; полный APK ещё требует пересборки

Пользователь просил использовать существующую DNS Connect эмблему с тремя серверами во всех местах, где должна отображаться иконка приложения.

- Исходная эмблема с тремя серверными блоками найдена в `app/src/main/res/drawable-nodpi/ic_dns_connect_foreground.png` (трёхсерверная иллюстрация с глобусом и щитом DNS).
- Декомпиляция опубликованного APK 2.1.0 подтвердила: manifest `android:icon` = `@mipmap/ic_launcher`, `android:roundIcon` = `@mipmap/ic_launcher_round`; оба ресурса и их API 33+ варианты используют `@drawable/ic_dns_connect_foreground`. Верхняя панель приложения также использует `R.drawable.ic_dns_connect_foreground`.
- Полный mipmap audit не обнаружил отдельных legacy PNG launcher icons в density-папках. `android:icon="@drawable/ic_dns_tile"` относится к системной DNS-плитке, а не к launcher app icon; его оставляем функциональным.
- Исключение: Android 13+ themed/monochrome launcher resource `app/src/main/res/drawable/ic_launcher_monochrome.xml` до этого показывал отдельный глобус/щит с двумя полосами. Он заменён на компактный монохромный символ из трёх серверных стоек.
- Новый supplementary patch: `bootstrap/patch-2.3.0/branding-3server-monochrome.patch`; size 3,058; SHA-256 `549bc339abbc254c460775de3b12cf9337050674ca52b7f1e127af9847a43c2c`.
- `bootstrap/rebuild-dns-connect-from-project-files.sh` теперь применяет этот патч после основной 2.3.0 diff, проверяет SHA и подтверждает, что все четыре launcher XML варианта и toolbar ссылаются на общий foreground. DNS Quick Settings tile и widget icons остаются функциональными значками, не заменяются брендингом.
- CI run `42584359364` — SUCCESS: actionlint, 13 main patch fragments, base64/gzip/diff hashes, supplementary patch hash и apply с `--fuzz=0`, три серверных уровня в themed icon, `bash -n` rebuild script.
- В опубликованной версии 2.1.0 пункт нижней навигации «Сервисы» сам по себе использует глиф `apps` (четыре квадрата), а generic `server` glyph — две горизонтальные стойки. Это отдельные функциональные навигационные глифы; найденная трёхсерверная эмблема — app brand foreground. Не заменять профильные навигационные/виджетные иконки логотипом.
- Из-за нового resource patch предыдущий APK/source candidate 2.3.0 устарел. Его старые hashes оставлены в `manifest.json` только для аудита и помечены как superseded. Текущий source+APK с branding patch ещё НЕ пересобран; hash нового кандидата не установлен.
- Не использовать генерацию коллажей и не рисовать новую эмблему вместо имеющейся.

## Фактический статус GitHub на 2026-11-09

- Public main содержит документацию, workflow и patch bootstrap, но Android Gradle project пока не импортирован в корень репозитория.
- Опубликованы только два дубликата release 2.1.0 (теги `v2.1.0` и `2.1.0`).
- `latest.json` всё ещё указывает на 2.1.0 / code 22 / SHA-256 `c05e9cb8af2b4193ba2c77fb29bcb889e7588af4e61825af34c92af900c09755`.
- Release 2.3.0 НЕ опубликован. Установленный updater пока не должен обнаруживать 2.3.0.
- Последняя проверка main workflow/lint/patch integrity: run 42567494192 — SUCCESS.
- Последний signing-secret check: run 42567494139 — workflow SUCCESS, но оба secrets отсутствуют.
- `.github/workflows/build-from-archive.yml` собирает ZIP из `incoming/DNS-Connect-*-source.zip`, проверяет package/version/signature/zipalign, готовит release assets и только после успешной проверки обновляет `latest.json`.
- Не менять `latest.json` до реальной публикации APK + source + checksums и проверки SHA/размера GitHub release assets.

## Критические правила продолжения

1. Сначала прочитать `NEXT-CHAT.md`, `HANDOFF.md`, `CHECKPOINT.md`.
2. Сверить Project Files и реальный GitHub main/workflow/release status; не полагаться на старые локальные пути предыдущего runtime.
3. Не просить пользователя повторно загрузить уже имеющиеся Project Files.
4. Не публиковать подпись/пароль и не менять signing certificate без осознанной причины.
5. Не заявлять об опубликованном 2.3.0, рабочем автообновлении или физическом тесте, пока это не подтверждено реальными данными.
6. После каждого существенного действия обновлять этот handoff и checkpoint.
