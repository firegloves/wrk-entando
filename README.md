# WRK-ENTANDO

What is [wrk2](https://github.com/giltene/wrk2)

wrk-entando is a docker image based on [`bootjp/wrk2`](https://hub.docker.com/r/bootjp/wrk2)

You can use this image to automate HTTP benchmarking.

## Basics

When the container starts, it executes `/wrk-script/wrk-start.sh`
The default behaviour of the script is to authenticate against Keycloak instance and then to execute a wrk script querying 10 endpoints in order to stress Entando app.
If you want to inspect the script you can find it at `/wrk-script/wrk-composite-app-stress-script.lua`

## Environment variables

Some environment variables are available and can be overridden:

| NAME             | DESCRIPTION                                                  | DEFAULT                                                                                 |
|------------------|--------------------------------------------------------------|-----------------------------------------------------------------------------------------|
| ENTANDO_BASE_URL | Base url of the Entando instance to run benchmarking against | http://keb-keb.apps.rd.entando.org/entando-de-app/api                                   |
| KC_AUTH_URL      | Keycloak instance url responsible for the authentication     | http://keb-kc-keb.apps.rd.entando.org/auth/realms/entando/protocol/openid-connect/token |
| KC_CLIENT_ID     | Keycloak client ID                                           | keb-de                                                                                  |
| KC_SECRET        | Keycloak secret                                              | e5927a70-d4f4-4d26-b1cb-34b709a79c75                                                    |
| WRK_THREADS      | wrk number of concurrent threads                             | 10                                                                                      |
| WRK_CONNECTIONS  | wrk number of concurrent connections                         | 500                                                                                     |
| WRK_DURATION     | wkr benchmarking duration time                               | 5m                                                                                      |
| WRK_RATE         | wkr total requests per second                                | 10                                                                                      |

Here an example changing wrk duration:

`docker run -e WRK_DURATION=10s entando-wrk`


## Volume

wrk-entando creates a volume at the path `/wrk-script`. You can override it supplying your desired `wrk-start.sh` to execute.
For example if you put your custom `wrk-start.sh` into `/Users/entando/myVolume` you can start entando-wrk as follows:

`docker run --volume=/Users/entando/myVolume:/wrk-script entando-wrk`