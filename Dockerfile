FROM alpine:3.7

MAINTAINER Takeru Sato <type.in.type@gmail.com>

ENV GEOIP_UPDATE_VERSION  2.5.0
ENV SRC_DL_URL_PREF       https://github.com/maxmind/geoipupdate/archive
ENV GEOIP_CONF_FILE       /usr/etc/GeoIP.conf
ENV GEOIP_DB_DIR          /usr/share/GeoIP

COPY GeoIP.conf.tmpl ${GEOIP_CONF_FILE}.tmpl
COPY run.sh /bin/
COPY ./crontabs/root /root/crontabs/

RUN BUILD_DEPS='gcc make libc-dev curl-dev zlib-dev libtool automake autoconf' \
 && apk add --update --no-cache curl ${BUILD_DEPS} \
 && curl -L "https://github.com/gliderlabs/sigil/releases/download/v0.4.0/sigil_0.4.0_$(uname -sm|tr \  _).tgz" | tar -zxC /usr/local/bin \
 && curl -L -o /tmp/geoipupdate-${GEOIP_UPDATE_VERSION}.tar.gz ${SRC_DL_URL_PREF}/v${GEOIP_UPDATE_VERSION}.tar.gz \
 && cd /tmp \
 && tar zxvf geoipupdate-${GEOIP_UPDATE_VERSION}.tar.gz \
 && cd /tmp/geoipupdate-${GEOIP_UPDATE_VERSION} \
 && ./bootstrap \
 && ./configure --prefix=/usr \
 && make \
 && make install \
 && cd \
 && apk del --purge ${BUILD_DEPS} \
 && rm -rf /var/cache/apk/* \
 && rm -rf /tmp/geoipupdate-* \
 && chmod 755 /bin/run.sh

CMD /bin/run.sh && crond -f -c /root/crontabs
