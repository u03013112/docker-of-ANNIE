FROM ubuntu as builder
WORKDIR /app
RUN apt update \
	&& apt install -y wget \ 
	&& wget https://github.com/iawia002/annie/releases/download/0.9.6/annie_0.9.6_Linux_64-bit.tar.gz \
	&& tar -zxvf annie_0.9.6_Linux_64-bit.tar.gz
	
FROM alpine as prod
WORKDIR /app
COPY --from=0 /app/annie .
RUN apk add --no-cache ffmpeg \
	&& mv annie /usr/bin
VOLUME /app
ENTRYPOINT ["annie"]
