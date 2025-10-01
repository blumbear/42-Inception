FROM alpine:3.16
RUN	apk update && apk upgrade && apk add --no-cache nginx openssl
COPY requirements/nginx/tools/entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
EXPOSE 443
ENTRYPOINT ["./entrypoint.sh"]