# DNS Connect — журнал изменений

## 2.1.0

- Исправлена подсветка нижней вкладки «Сеть» на экране скорости интернета.
- Добавлены регрессионные тесты обновления 2.0.0 → 2.1.0 и проверки точных URL/tag GitHub Releases.
- Исправлена согласованность метаданных README и build-конфигурации.
- Gradle release требует внешний постоянный JKS и не допускает неявную неподписанную релизную сборку.
- Финальный локальный прогон: 262 PASS, 0 FAIL.

Примечание: APK asset и манифест latest.json должны публиковаться вместе как согласованный релизный набор. Пока Release asset не загружен, текущая сборка не доступна для обновления через приложение.

## Public in-app update setup

- Added a GitHub Actions workflow to copy the already-uploaded APK from the unprefixed tag `2.1.0` to the updater's required `v2.1.0` tag.
- The workflow verifies exact SHA-256 and size before uploading and publishes `latest.json` only after verifying the target Release asset.
- One manual workflow_dispatch run is required because the connector's commit did not trigger GitHub Actions automatically.
