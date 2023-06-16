FROM alpine
ADD dockertesttar.tar.gz /usr/src/
COPY dockertestatr.tar.gz /var/lib/apk/
WORKDIR /usr/src
