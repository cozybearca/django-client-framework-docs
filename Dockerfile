FROM alpine

RUN apk add --update \
    alpine-sdk \
    python3 \
    py3-pip
COPY . /doc-builder
WORKDIR /doc-builder
RUN pip3 install -r requirements.txt
