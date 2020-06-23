#!/bin/sh

export ENTANDO_BASE_URL=http://quickstart-fireg.apps.rd.entando.org
export KC_AUTH_URL=http://quickstart-kc-fireg.apps.rd.entando.org/auth/realms/entando/protocol/openid-connect/token
export KC_CLIENT_ID=dummy
export KC_SECRET=dummy
export WRK_THREADS=10
export WRK_CONNECTIONS=500
export WRK_DURATION=5m
export WRK_TIMEOUT=10s
export WRK_RATE=10

# authenticates and set jwt variable that will be used inside lua script
AUTHENTICATION_SCRIPT="./authenticate.sh"
. "$AUTHENTICATION_SCRIPT"

startDate=`date "+%Y-%m-%d %H:%M:%S"`

# command using env variables
wrk2 -t $WRK_THREADS -c $WRK_CONNECTIONS -d $WRK_DURATION --timeout $WRK_TIMEOUT -R $WRK_RATE -s ./wrk-composite-app-stress-script.lua $ENTANDO_BASE_URL -- $jwt

endDate=`date "+%Y-%m-%d %H:%M:%S"`

echo "\nSTARTED AT: $startDate"
echo "ENDED AT: $endDate"