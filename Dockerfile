FROM ubuntu:latest

RUN apt update \
    && apt install -y vim \
    && rm -rf /var/lib/apt/lists/

COPY deps/. /deps

RUN export METPATH=/opt/OpenWeather \
    && useradd -u 1001 vwadmin \
    && mkdir -p $METPATH \
    && chown 1001:1001 $METPATH \
    && mkdir /app \
    && chown -R 1001:1001 /app \
    && chown -R 1001:1001 /deps \
    && chmod +x /deps/openweather-6.4.2-stable-20210820-community-linux.run

USER vwadmin

ENV METPATH=/opt/OpenWeather
ENV PATH=${METPATH}/config/bin:${METPATH}/bin:${METPATH}/etc:${PATH}

WORKDIR ${METPATH}

COPY ./requirements.txt /deps
RUN umask 0002 \
    && sh /deps/openweather-6.4.2-stable-20210820-community-linux.run \
    && pip install -r /deps/requirements.txt

WORKDIR /app

COPY app/ /app

CMD uvicorn main:app --host 0.0.0.0