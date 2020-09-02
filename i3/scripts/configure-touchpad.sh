#!/bin/sh

ID=$(xinput | grep "Touchpad" | grep -oE 'id=[0-9]+' | grep -oE '[0-9]+')
PROP=$(xinput list-props ${ID} | grep -oE "Tapping Enabled \([0-9]+\)" | grep -oE '[0-9]+')
xinput set-prop ${ID} ${PROP} 1