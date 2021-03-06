FROM ubuntu as builder
WORKDIR /app
RUN apt update \
	&& apt install -y wget \ 
	&& wget https://github.com/iawia002/annie/releases/download/0.10.3/annie_0.10.3_Linux_64-bit.tar.gz \
	&& tar -zxvf annie_0.10.3_Linux_64-bit.tar.gz
	
FROM alpine as prod
WORKDIR /app
COPY --from=0 /app/annie .
RUN apk add --no-cache ffmpeg \
	&& mv annie /usr/bin
VOLUME /app
ENTRYPOINT ["annie"]
