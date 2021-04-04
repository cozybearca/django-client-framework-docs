FROM alpine

RUN apk add --update \
    alpine-sdk \
    python3 py3-pip \
    nginx \
    nodejs npm
COPY requirements.txt /requirements.txt
RUN pip3 install -r /requirements.txt
RUN npm install -g typedoc typescript
COPY nginx.conf /etc/nginx/nginx.conf
COPY Makefile /Makefile
WORKDIR /
RUN mkdir -p /run/nginx/
RUN nginx -t
