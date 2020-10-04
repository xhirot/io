FROM alpine:latest
 
RUN mkdir -m 777 /web && cd /web \
 && apk add --no-cache ca-certificates curl --virtual .build-deps \
 && curl -L -H "Cache-Control: no-cache" -o latest.zip https://github.com/v2fly/v2ray-core/releases/latest/download/v2ray-linux-64.zip \
 && unzip latest.zip v2ray v2ctl geoip.dat geosite.dat \
 && mv v2ray caddy \
 && apk del .build-deps \
 && chmod +x /web/caddy \
 && chgrp -R 0 /web \
 && chmod -R g+rwX /web 
 
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
CMD /entrypoint.sh