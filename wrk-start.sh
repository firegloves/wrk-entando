#!/bin/sh

# authenticates agains keycloak
payload="grant_type=client_credentials&client_id=${KC_CLIENT_ID}&client_secret=${KC_SECRET}"
authResult=$(curl -d $payload -X POST $KC_AUTH_URL)

# checks for error
error=$(echo $authResult | cut -d',' -f1 | cut -d':' -f1 | cut -d'"' -f2)
if [ "$error" == "error" ]; then

	errorMex=$(echo $authResult | cut -d',' -f1 | cut -d':' -f2 | cut -d',' -f1)
	echo "### ERROR: ${errorMex}"

else

  echo ''
	echo '######################'
	echo 'Authenticated'
	echo '######################'
	echo "Starting wrk script against ${ENTANDO_BASE_URL}..."
	echo '######################'
	echo ''

	jwt=$(echo $authResult | cut -d'"' -f4)

	wrk2 -t 1 -c 1 -d 30s --timeout 10s -R 1 -s ./wrk-composite-app-stress-script.lua $ENTANDO_BASE_URL -- $jwt
#	wrk2 -t $WRK_THREADS -c $WRK_CONNECTIONS -d $WRK_DURATION --timeout 10s -R $WRK_RATE -s ./wrk-composite-app-stress-script.lua $ENTANDO_BASE_URL -- $jwt
fi