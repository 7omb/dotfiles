#!/bin/sh
set -eu

TITLE="$1"
TEXT="systemd service $1 failed"

if command -v kdialog; then
    kdialog --title "$TITLE" --passivepopup "$TEXT"
fi
