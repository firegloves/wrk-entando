#!/bin/sh

export ENTANDO_BASE_URL=http://myapp-keb.apps.rd.entando.org
export KC_AUTH_URL=http://keb-kc-keb.apps.rd.entando.org/auth/realms/entando/protocol/openid-connect/token
export KC_CLIENT_ID=
export KC_SECRET=
export WRK_THREADS=10
export WRK_CONNECTIONS=500
export WRK_DURATION=1s
export WRK_RATE=1

# authenticates and set jwt variable that will be used inside lua script
AUTHENTICATION_SCRIPT="./authenticate.sh"
. "$AUTHENTICATION_SCRIPT"

# static command that needs only $ENTANDO_BASE_URL env var
wrk2 -t 1 -c 1 -d 1s --timeout 10s -R 1 -s ./wrk-composite-app-stress-script.lua "$ENTANDO_BASE_URL" -- $jwt

# command using env variables
#wrk2 -t $WRK_THREADS -c $WRK_CONNECTIONS -d $WRK_DURATION --timeout 10s -R $WRK_RATE -s ./wrk-composite-app-stress-script.lua $ENTANDO_BASE_URL -- $jwt
