#!/usr/bin/env bash
set -euo pipefail

# Rebuild DNS Connect 2.3.0 from the persistent Project Files inputs.
# Usage:
#   DNS_RELEASE_KEYSTORE_PASSWORD=... \
#   ./rebuild-dns-connect-from-project-files.sh \
#     "/mnt/data/2.1.0.zip" "/mnt/data/Download Zip.zip" \
#     "/secure/path/dnsconnect-release.jks" "/mnt/data/dnsconnect-release" \
#     ["/path/to/pre-fetched-patch-chunks"]
#
# The signing password is read only from the process environment.
# Never put signing material in the source ZIP, public repo, or logs.

PROJECT_ARCHIVE="${1:?Project 2.1.0.zip is required}"
SDK_BUNDLE="${2:?Project Download Zip.zip is required}"
KEYSTORE="${3:?Private release keystore is required}"
OUTPUT_DIR="${4:?Output directory is required}"
PATCH_CACHE="${5:-}"

: "${DNS_RELEASE_KEYSTORE_PASSWORD:?Set DNS_RELEASE_KEYSTORE_PASSWORD securely in the process environment}"
DNS_RELEASE_KEY_ALIAS="${DNS_RELEASE_KEY_ALIAS:-dnsconnect}"
DNS_RELEASE_KEY_PASSWORD="${DNS_RELEASE_KEY_PASSWORD:-$DNS_RELEASE_KEYSTORE_PASSWORD}"

REPO="Krenas/DNS-Connect"
PATCH_DIR="$OUTPUT_DIR/patch-2.3.0"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

for file in "$PROJECT_ARCHIVE" "$SDK_BUNDLE" "$KEYSTORE"; do
  [[ -s "$file" ]] || { echo "Required input is missing: $file" >&2; exit 2; }
done
mkdir -p "$OUTPUT_DIR" "$PATCH_DIR" "$WORK/base" "$WORK/source"

unzip -tq "$PROJECT_ARCHIVE" >/dev/null
unzip -p "$PROJECT_ARCHIVE" "DNS-Connect-2.1.0-source.zip" > "$WORK/DNS-Connect-2.1.0-source.zip"
test -s "$WORK/DNS-Connect-2.1.0-source.zip"
unzip -tq "$WORK/DNS-Connect-2.1.0-source.zip" >/dev/null

EXPECTED_LENGTHS=(3000 3000 3000 3000 3000 3000 3000 3000 3000 3000 3000 3000 2132)
EXPECTED_SHA256=(
  0fbc4ef41eec8c953a9c262ee2110e87dc3a739f7ab0efc3f9f3c4d31e60b199
  4e00568e021e30f9218ef446ac47fc23774b8a9413dc68b7ec704186e340db11
  3ff6101f3ed4db53507ab701269b7383c9c0ae580c11ab76410576c5ada5c862
  465de8794e5e97f25597126ff365a174ec0d86585eea84f8e2d17a87dead2dbf
  742de2aea4786c68ce65607f9d52ba267e4ec3258eef7c444118ff40a6985bec
  bd186cea26d1e5e5ab21bb1765874ae981926e3b7993cdde8713134a56ae25eb
  779b8c85725bfbfb1a4bdfdb673d3ebc9d2c7d31d3be65cc27d694fab49430fc
  97ebaa36d0ae201d1ca0681f3d8dba723e075a9b294e6990e70a9ddda3b21d57
  39d922f46846bee6f6cce522cb3645a98564a82dd3bab36959f4cf960ae84af6
  f00723c473046306cbcaa3e70dcb9fba190663db77b89cdd2381cb97e4636f32
  e573779d356fc7417eeb9e2c8c3ac8a6c34b470050bd91deb795b9c86fa90365
  8b93a773f16925ea4303f52d63c734f4a2ab40c6582b8c1bc542ed402c05a10c
  d69971050875bc4e42f044a28b7c4586aa28210b3182eb46479f13e1a2501b90
)

for index in $(seq 0 12); do
  number="$(printf '%03d' "$index")"
  file="$PATCH_DIR/$number.b64"
  if [[ -n "$PATCH_CACHE" && -s "$PATCH_CACHE/$number.b64" ]]; then
    cp "$PATCH_CACHE/$number.b64" "$file"
  else
    curl --fail --silent --show-error \
      "https://raw.githubusercontent.com/$REPO/main/bootstrap/patch-2.3.0/$number.b64" \
      -o "$file"
  fi
  actual_length="$(wc -c < "$file" | tr -d ' ')"
  [[ "$actual_length" = "${EXPECTED_LENGTHS[$index]}" ]] || {
    echo "Patch chunk $number has the wrong length." >&2
    exit 3
  }
  echo "${EXPECTED_SHA256[$index]}  $file" | sha256sum --check >/dev/null
done

cat "$PATCH_DIR"/{000..012}.b64 > "$WORK/patch.b64"
echo "9a77468bebbe2b5b5e5f412a125f9dec160c5f9e85e2dbd4971388c7a93233ba  $WORK/patch.b64" | sha256sum --check
base64 --decode "$WORK/patch.b64" > "$WORK/patch.gz"
echo "c08066e4be234e3405baa0dc0a563b3e5dce07036a81194846169807033c4f47  $WORK/patch.gz" | sha256sum --check
gzip -t "$WORK/patch.gz"
gzip --decompress --stdout "$WORK/patch.gz" > "$WORK/DNS-Connect-2.3.0.patch"
echo "0d2e4baaa30f1d336f32a6f92f293536f3b12498681f641d4870ff9c16a756d1  $WORK/DNS-Connect-2.3.0.patch" | sha256sum --check

unzip -q "$WORK/DNS-Connect-2.1.0-source.zip" -d "$WORK/source"
patch --batch --forward --fuzz=0 -p1 -d "$WORK/source" < "$WORK/DNS-Connect-2.3.0.patch"

# Apply the supplemental branding patch: Android 13+ themed icons must use
# the same three-server mark as the adaptive launcher foreground and toolbar.
curl --fail --silent --show-error --retry 3 \
  "https://raw.githubusercontent.com/$REPO/main/bootstrap/patch-2.3.0/branding-3server-monochrome.patch" \
  -o "$WORK/DNS-Connect-2.3.0-three-server-branding.patch"
echo "4bc4ee8bce82316c712da063621994a2facd250b397e86316acb4774e0e17a5a  $WORK/DNS-Connect-2.3.0-three-server-branding.patch" | sha256sum --check
patch --batch --forward --fuzz=0 -p1 -d "$WORK/source" < "$WORK/DNS-Connect-2.3.0-three-server-branding.patch"

# Guard every true app-icon placement against accidentally drifting apart.
for launcher in \
  app/src/main/res/mipmap-anydpi/ic_launcher.xml \
  app/src/main/res/mipmap-anydpi/ic_launcher_round.xml \
  app/src/main/res/mipmap-anydpi-v33/ic_launcher.xml \
  app/src/main/res/mipmap-anydpi-v33/ic_launcher_round.xml; do
  grep -Fq '@drawable/ic_dns_connect_foreground' "$WORK/source/$launcher" || {
    echo "Launcher variant does not use the three-server foreground: $launcher" >&2
    exit 6
  }
done
grep -Fq 'imageView.setImageResource(R.drawable.ic_dns_connect_foreground)' \
  "$WORK/source/app/src/main/java/ru/krenas/dnsanalytics/MainActivity.java" || {
  echo "The in-app brand mark does not use the launcher foreground." >&2
  exit 6
}
grep -Fq 'M29,17 H79' "$WORK/source/app/src/main/res/drawable/ic_launcher_monochrome.xml" || {
  echo "Android themed launcher icon is missing the three-server rack mark." >&2
  exit 6
}

VERSION="$(sed -nE 's/^[[:space:]]*versionName[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/p' "$WORK/source/app/build.gradle.kts" | head -n1)"
VERSION_CODE="$(sed -nE 's/^[[:space:]]*versionCode[[:space:]]*=[[:space:]]*([0-9]+).*/\1/p' "$WORK/source/app/build.gradle.kts" | head -n1)"
PACKAGE="$(sed -nE 's/^[[:space:]]*applicationId[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/p' "$WORK/source/app/build.gradle.kts" | head -n1)"
[[ "$VERSION" = "2.3.0" && "$VERSION_CODE" = "24" && "$PACKAGE" = "ru.krenas.dnsanalytics" ]] || {
  echo "Patched source identity does not match the expected DNS Connect 2.3.0 release." >&2
  exit 4
}

SOURCE_ZIP="$OUTPUT_DIR/DNS-Connect-$VERSION-source.zip"
(
  cd "$WORK/source"
  zip -q -r "$SOURCE_ZIP" . \
    -x './build/*' './build/**' './.git/*' './.git/**' './*.apk' './*.zip' './*.jks' './*.keystore' \
       './*password*' './BUILD-*.log' './release-output/*' './release-output/**'
)
unzip -tq "$SOURCE_ZIP" >/dev/null

export DNS_RELEASE_KEYSTORE="$KEYSTORE" DNS_RELEASE_KEY_ALIAS DNS_RELEASE_KEY_PASSWORD
bash "$WORK/source/build-from-project-files.sh" \
  "$SOURCE_ZIP" "$SDK_BUNDLE" "$KEYSTORE" "$OUTPUT_DIR/release"

APK="$OUTPUT_DIR/release/DNS-Connect-$VERSION-release.apk"
SOURCE_RELEASE="$OUTPUT_DIR/release/DNS-Connect-$VERSION-source.zip"
test -s "$APK" && test -s "$SOURCE_RELEASE"
"$WORK/source/prepare-android-sdk.sh" "$SDK_BUNDLE" "$WORK/verify-sdk" >/dev/null
CERT="$("$WORK/verify-sdk/build-tools/35.0.0/apksigner" verify --print-certs "$APK" | sed -n 's/^Signer #1 certificate SHA-256 digest: *//p' | head -n1 | tr '[:upper:]' '[:lower:]')"
[[ "$CERT" = "4dc48085b7ea161b57e6266611c5d6a28514df6f2ddfc26df14f3ac972debf90" ]] || {
  echo "Release signer does not match the preserved certificate." >&2
  exit 5
}

echo "DNS Connect $VERSION rebuilt successfully."
echo "APK: $APK"
echo "Source: $SOURCE_RELEASE"
echo "Release pack: $OUTPUT_DIR/release/DNS-Connect-$VERSION-release-pack.zip"
