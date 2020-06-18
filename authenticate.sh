#!/bin/sh

# authenticates agains keycloak
payload="grant_type=client_credentials&client_id=${KC_CLIENT_ID}&client_secret=${KC_SECRET}"
authResult=$(curl -d $payload -X POST $KC_AUTH_URL)

# checks for error
error=$(echo $authResult | cut -d',' -f1 | cut -d':' -f1 | cut -d'"' -f2)
if [ "$error" == "error" ]; then

	errorMex=$(echo $authResult | cut -d',' -f1 | cut -d':' -f2 | cut -d',' -f1)

	echo '######################'
	echo "### ERROR: ${errorMex}"
  echo '######################'

  exit 1

else

  echo ''
	echo '######################'
	echo 'Authenticated'
	echo '######################'
	echo "Starting wrk script against ${ENTANDO_BASE_URL}..."
	echo '######################'
	echo ''

	jwt=$(echo $authResult | cut -d'"' -f4)

#	return jwt
fi