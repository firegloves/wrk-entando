FROM bootjp/wrk2
#FROM williamyeh/wrk

RUN apk --no-cache add curl

ENV ENTANDO_BASE_URL http://keb-keb.apps.rd.entando.org/entando-de-app/api
ENV KC_AUTH_URL http://keb-kc-keb.apps.rd.entando.org/auth/realms/entando/protocol/openid-connect/token
ENV KC_CLIENT_ID keb-de
ENV KC_SECRET e5927a70-d4f4-4d26-b1cb-34b709a79c75
ENV WRK_THREADS 10
ENV WRK_CONNECTIONS 500
ENV WRK_DURATION 10s
ENV WRK_RATE 10

VOLUME /wrk-script

COPY ./wrk-start.sh /wrk-script/wrk-start.sh
COPY ./wrk-composite-app-stress-script.lua /wrk-script/wrk-composite-app-stress-script.lua

ENTRYPOINT ["/wrk-script/wrk-start.sh"]
