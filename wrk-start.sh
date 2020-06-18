#!/bin/sh

# authenticates and set jwt variable that will be used inside lua script
AUTHENTICATION_SCRIPT="./authenticate.sh"
. "$AUTHENTICATION_SCRIPT"

# start http benchmarking
wrk2 -t $WRK_THREADS -c $WRK_CONNECTIONS -d $WRK_DURATION --timeout 10s -R $WRK_RATE -s ./wrk-composite-app-stress-script.lua $ENTANDO_BASE_URL -- $jwt