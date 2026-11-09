# NEXT-CHAT — DNS Connect

**Start here when opening a new chat in the existing ChatGPT Project «DNS».**

Do not ask the user to repeat the project brief or upload the same archives. Find the Project Files by name and read:
1. `HANDOFF.md`
2. `CHECKPOINT.md`
3. Public repository status at https://github.com/Krenas/DNS-Connect

## User's standing instruction

Continue the existing DNS Connect Android app, not a redesign/rebuild from scratch. Work proactively without asking the user to perform routine technical steps. Inspect source, make changes, test in cycles, fix failures, and update this repository checkpoint after substantial work. User expects a working APK and usable direct GitHub release link, plus a functioning updater. Communicate in Russian and keep technical status explicit (PASS / FAIL / NOT TESTED).

## Start-up checklist for the assistant

- Discover current Project Files. Expected inputs:
  - `2.1.0.zip` — immutable base (contains source ZIP and existing APK).
  - `DNS-Connect-2.1.0-source.zip` — separately extracted source copy, if still listed.
  - `Download Zip.zip` and/or the smaller Android SDK 35 platform/build-tools bundles.
  - `HB_AI_Xbox_DNS.exe` — original Windows reference functionality.
- Do not assume any old `/mnt/data` path from a previous chat still exists. Materialize from Project Files into the current runtime and verify actual paths.
- Fetch current `main`, latest releases, `latest.json`, workflow state, and the patch manifest from GitHub. Treat remote status as authoritative.
- Reconstruct 2.3.0 from the 2.1.0 source and `bootstrap/patch-2.3.0/`; verify chunk length/SHA and patch SHA; use `patch --fuzz=0`.
- Three-server app brand foreground has been identified: `app/src/main/res/drawable-nodpi/ic_dns_connect_foreground.png`. The adaptive launcher variants and toolbar already use it. The Android 13+ monochrome icon mismatch has been corrected in `bootstrap/patch-2.3.0/branding-3server-monochrome.patch`; the rebuild script applies it and verifies launcher/toolbar references. The generic «Сервисы» nav glyph in 2.1.0 is `apps` (four squares), while `server` is two bars — do not confuse those functional glyphs with the brand image. CI run 42584359364 passed the supplementary patch test. Rebuild 2.3.0 with this patch and recalculate all artifact hashes.
- Rebuild, run all source tests, inspect APK identity and signer, run zipalign/signature verification, and make a QA report. Physical device, actual DNS, widgets, Quick Settings and live in-app update still need real device validation.
- Keep the existing signing fingerprint. Do not expose or commit any JKS/password/Base64 signer data.

## New app-icon finding

The existing three-server brand image is already the launcher foreground and toolbar logo. The Android 13+ monochrome resource has now been aligned using the supplemental patch. Previous APK/source hashes from before this change are invalid for the next candidate; a fresh build is required.

## Known release blocker

The current public build workflow expects exactly two repository Actions secrets:
- `ANDROID_KEYSTORE_BASE64`
- `ANDROID_KEYSTORE_PASSWORD`

The last secret-check run reported both missing. The current GitHub connector does not expose an operation to set Actions secrets. Continue searching for a secure supported route; never work around this by committing signing material to the public repository. If no secure route exists, the only user-side step is to add those two values at:
https://github.com/Krenas/DNS-Connect/settings/secrets/actions

## Current public repo status (verify again; do not trust blindly)

- Release 2.3.0 is not published.
- `latest.json` still points to 2.1.0.
- Public main has workflows, docs, patch bootstrap, but the app Gradle project has not been imported.
- The permanent 2.3.0 patch is present and validated. See `HANDOFF.md` for hashes and candidate metadata.
- Do not update `latest.json` before APK/source/checksum assets have been uploaded and their SHA/size verified.

## Required handoff discipline

After each important milestone, update `HANDOFF.md` and `CHECKPOINT.md` in this public repo. At any point a new chat should be able to restart from these files and the Project Files without relying on transient chat context or a stale local path.
