#!/bin/bash

source ~/.dotfiles/env.sh

IFCONFIG=$(curl -s ifconfig.co/json)
LATLON=$(echo $IFCONFIG | jq -r '[.latitude, .longitude] | join(",")')

RESPONSE=$(curl -s "https://maps.googleapis.com/maps/api/timezone/json?location=${LATLON}&timestamp=1458000000&key=${GOOGLE_MAPS_APIKEY}")
TIMEZONE=$(echo $RESPONSE | jq -r '.timeZoneId')

SUCCESS=$(sudo timedatectl set-timezone ${TIMEZONE});