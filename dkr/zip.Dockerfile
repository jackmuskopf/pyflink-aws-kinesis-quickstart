FROM ubuntu:22.04

WORKDIR /app

RUN apt-get update -y
RUN apt-get install zip dos2unix wget -y