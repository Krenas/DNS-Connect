# DNS Connect

Приложение Android для проверки DNS, сетевого соединения и доступности сервисов.

- Package: ru.krenas.dnsanalytics
- Android 8.0+ (API 26)
- Публичный проект: https://github.com/Krenas/DNS-Connect
- Исходники, APK и контрольные точки разработки находятся в Project Files проекта ChatGPT DNS.

## Скачать
- Последний опубликованный релиз: https://github.com/Krenas/DNS-Connect/releases/latest
- Все релизы: https://github.com/Krenas/DNS-Connect/releases
- Манифест обновлений: https://raw.githubusercontent.com/Krenas/DNS-Connect/main/latest.json

## Продолжение работы без повторной загрузки
Новый чат нужно создавать внутри того же ChatGPT Project «DNS». Он должен прочитать HANDOFF.md и CHECKPOINT.md, затем найти последние source ZIP/APK в Project Files. Пользователя не нужно просить отправлять их повторно. После каждого существенного изменения handoff и checkpoint обновляются, чтобы можно было продолжить, даже если текущий чат завершится.

## Статус 2.3.0
Кандидат 2.3.0 локально собран и прошёл 234 автоматические проверки без FAIL; release package validation — 14 PASS / 0 FAIL. GitHub Release 2.3.0 пока не опубликован, а latest.json остаётся на 2.1.0. Исходный snapshot 2.3.0 уже есть в Project Files; для нового чата повторная загрузка не нужна. Проверяйте фактический статус по HANDOFF.md и публичному манифесту.

## Встроенное обновление
В приложении updater проверяет версию, URL, размер, SHA-256, пакет и сертификат APK, затем передаёт его системному установщику Android. Android требует подтверждения установки пользователем. Нельзя считать обновление готовым до публикации проверенного релиза и теста на устройстве.
