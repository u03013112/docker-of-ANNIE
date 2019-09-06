FROM ubuntu as builder
WORKDIR /app
RUN sed -i s@/archive.ubuntu.com/@/mirrors.aliyun.com/@g /etc/apt/sources.list \
	&& apt update \
	&& apt install -y wget \ 
	&& wget https://github.com/iawia002/annie/releases/download/0.9.5/annie_0.9.5_Linux_64-bit.tar.gz \
	&& tar -zxvf annie_0.9.5_Linux_64-bit.tar.gz
	
FROM alpine as prod
WORKDIR /app
COPY --from=0 /app/annie .
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories \
	&& apk add --no-cache ffmpeg \
	&& mv annie /usr/bin
VOLUME /app
ENTRYPOINT ["annie"]
