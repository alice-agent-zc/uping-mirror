#!/bin/sh
# uping — one-shot install helper (run as root).
#
#   sudo ./install.sh
#
# Assumes the release binary is already at /usr/local/bin/uping and the config
# is at /etc/uping/config.toml.
set -eu

BIN=/usr/local/bin/uping
CONF=/etc/uping/config.toml
UNIT=/etc/systemd/system/uping.service

[ -x "$BIN" ]  || { echo "missing $BIN — copy the release binary first"; exit 1; }
[ -f "$CONF" ] || { echo "missing $CONF — copy your config first"; exit 1; }

install -m 0644 "$(dirname "$0")/uping.service" "$UNIT"

systemctl daemon-reload
systemctl enable --now uping
systemctl --no-pager --full status uping
