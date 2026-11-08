# DNS Connect

**DNS Connect 2.1.0** — Android-приложение для диагностики DNS, доступности интернет-сервисов и состояния сетевого подключения.

- Android 8.0+ (API 26)
- Package: `ru.krenas.dnsanalytics`
- versionName: `2.1.0`
- versionCode: `22`
- targetSdk: 35

## Скачать

[**Скачать DNS Connect 2.1.0 APK**](https://github.com/Krenas/DNS-Connect/releases/download/v2.1.0/DNS-Connect-2.1.0-release.apk)

[Все релизы](https://github.com/Krenas/DNS-Connect/releases)

## Публикация APK без ручной загрузки в Releases

Для загрузки готового APK используется временная ветка `apk-upload/vMAJOR.MINOR.PATCH` и папка `incoming/`. Бинарный APK можно записать в Git-объекты GitHub через Git Data API (blob в Base64 → tree → commit → ref), не помещая его в историю основной ветки.

После push GitHub Actions автоматически:
1. Проверяет package name, versionName, versionCode, имя файла, размер и SHA-256.
2. Сверяет сертификат подписи с постоянным ключом DNS Connect 2.2.x.
3. Создаёт черновик Release, прикрепляет APK и проверяет данные вложения.
4. Публикует Release и обновляет `latest.json` с прямой ссылкой, SHA-256 и размером.
5. Удаляет временную ветку загрузки.

Путь APK в upload-ветке: `incoming/DNS-Connect-VERSION-release.apk`. Ветка должна называться `apk-upload/vVERSION`. Обычный пользователь и установленное приложение не получают GitHub-токен. Приложение продолжает загружать APK только из публичных Release Assets и сверять подпись.

Workflow: [Publish APK uploaded by ChatGPT](.github/workflows/publish-uploaded-apk.yml).

## Возможности

- Проверка DNS-серверов UDP, DoT и DoH.
- Сравнение задержки и диагностика доступности сервисов.
- Каталог DNS-профилей с фильтрами по назначению.
- Схематичное отображение приблизительной IP-географии.
- История результатов, экспорт и восстановление резервной копии.
- Виджеты DNS, скорости, сервисов и быстрых действий.
- Системная плитка Android для быстрого запуска диагностики.
- Проверка обновлений через публичный GitHub-манифест, с проверкой SHA-256, пакета и сертификата, затем установка через Android.

## Обновления в приложении

Публичный манифест уже опубликован: [latest.json](https://raw.githubusercontent.com/Krenas/DNS-Connect/main/latest.json).

Приложение:
1. Получает текущую версию из `latest.json`.
2. Сверяет версию, тег, URL, размер и SHA-256.
3. Загружает APK с проверенного GitHub Release.
4. Проверяет пакет, versionCode, Android API и совпадение сертификата подписи.
5. Передаёт APK системному установщику Android; установка требует подтверждения пользователя.

Для следующих выпусков настроен автоматический GitHub Actions workflow: [Publish latest.json after a stable release](https://github.com/Krenas/DNS-Connect/actions/workflows/publish-latest-manifest.yml). После публикации обычного стабильного релиза с тегом `vMAJOR.MINOR.PATCH` и APK с именем `DNS-Connect-MAJOR.MINOR.PATCH-release.apk` workflow проверит файл и обновит `latest.json`. Новый APK обязательно должен быть подписан тем же закрытым ключом, что и установленная версия.

## Приватность и ограничения

- Приложение предназначено для диагностики и не меняет системный DNS телефона, не создаёт VPN.
- Сопоставление с OONI выключено по умолчанию и требует явного согласия в настройках.
- Наблюдения OONI не являются официальным реестром РКН.
- IP-геолокация приблизительна и не определяет точное местоположение человека.
- Windows-only операции исходного EXE не эмулируются на Android.

## Проверка сборки 2.1.0

- 104 логических теста: PASS.
- 17 проверок каталога DNS: PASS.
- 141 UI/ресурсная/навигационная проверка: PASS.
- Всего: **262 PASS, 0 FAIL**.
- APK Signature Scheme v2/v3 и zipalign: PASS.
- Физическое устройство и реальные сетевые сценарии: NOT TESTED.

## Контрольные суммы

См. [SHA256SUMS.txt](SHA256SUMS.txt) и [CHANGELOG.md](CHANGELOG.md).
