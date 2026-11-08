# DNS Connect

Android-приложение для диагностики DNS-резолверов, интернет-подключения и выбранных сервисов.

- Package: ru.krenas.dnsanalytics
- Android 8.0+ (API 26)
- Публичный репозиторий: https://github.com/Krenas/DNS-Connect
- Инструкция продолжения и точный статус: HANDOFF.md
- Контрольная точка: CHECKPOINT.md

## Скачать
- Последний опубликованный релиз: https://github.com/Krenas/DNS-Connect/releases/latest
- Все релизы: https://github.com/Krenas/DNS-Connect/releases
- Манифест встроенного обновления: https://raw.githubusercontent.com/Krenas/DNS-Connect/main/latest.json

## Продолжение без повторной загрузки файлов
Создавайте новый чат внутри того же ChatGPT Project DNS. Все Project Files доступны чатам проекта; повторно отправлять исходные файлы пользователю не нужно. Project Files сейчас содержат предыдущий snapshot 2.3.0; свежая clean rebuild 2.3.0 пока доступна в локальных артефактах текущего чата, но не добавлена в Project Files из-за временного ограничения сохранения. Сверяйте HANDOFF.md и CHECKPOINT.md и не считайте GitHub Release 2.3.0 опубликованным.

## Повторяемая сборка
Source ZIP содержит build-from-project-files.sh. Он использует SDK-комплект Download Zip.zip, извлекает Android build-tools 35/platform 35, компилирует, проверяет, подписывает APK постоянным ключом и создаёт versioned source ZIP, latest.json, SHA256SUMS и release pack. Версия автоматически считывается из Gradle. Пароль ключа — только через защищённую переменную среды; JKS никогда не включается в public source ZIP.

## Статус 2.3.0
Кандидат 2.3.0 локально проверен через чистый архивно-SDK build pipeline: 115 DNS/logical PASS, 17 catalogue PASS, 11 build-driver PASS, UI/resource audit PASS, release package 14 PASS / 0 FAIL. Но GitHub Release 2.3.0 ещё не опубликован, а latest.json всё ещё указывает на 2.1.0. Смотри актуальный HANDOFF.md и публичный манифест; не считай updater готовым к обнаружению 2.3.0 до проверки GitHub Release.

## Встроенное обновление
Приложение валидирует версию, URL, размер, SHA-256, package ID и сертификат загруженного APK, затем открывает Android Installer. Android требует подтверждения установки. Ежедневная автопроверка только уведомляет о доступной версии; не устанавливает её молча.

## Подпись
2.1.0 использовал другой сертификат. Первый переход требует backup, uninstall, install и restore. Последующие версии должны использовать сохранённый 2.2.x+ ключ. Не публикуйте JKS или пароль.
