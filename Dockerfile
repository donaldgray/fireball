FROM alpine:3.9

RUN apk add --update --no-cache --virtual=run-deps \
  python3 \
  uwsgi \
  uwsgi-http \
  uwsgi-python3 \
  ca-certificates

WORKDIR /opt/fireball

CMD [ "uwsgi", "--plugins", "http,python3", "--http", "0.0.0.0:80", "--module", "wsgi" ]

EXPOSE 80
COPY requirements.txt /opt/fireball/requirements.txt
RUN pip3 install --no-cache-dir -r /opt/fireball/requirements.txt
COPY app /opt/fireball
