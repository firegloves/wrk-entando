FROM bootjp/wrk2

RUN apk --no-cache add curl

ENV ENTANDO_BASE_URL http://quickstart-fireg.apps.rd.entando.org
ENV KC_AUTH_URL http://quickstart-kc-fireg.apps.rd.entando.org/auth/realms/entando/protocol/openid-connect/token
ENV KC_CLIENT_ID dummy
ENV KC_SECRET  dummy
ENV WRK_THREADS 10
ENV WRK_CONNECTIONS 500
ENV WRK_DURATION 10s
ENV WRK_RATE 10

VOLUME /wrk-script

COPY ./wrk-start.sh /wrk-script/wrk-start.sh
COPY ./wrk-composite-app-stress-script.lua /wrk-script/wrk-composite-app-stress-script.lua

ENTRYPOINT ["/wrk-script/wrk-start.sh"]
