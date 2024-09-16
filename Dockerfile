FROM ubuntu:latest

RUN apt-get update && \
    apt-get update && apt-get install -y openssh-client openjdk-11-jdk openssl && \
    apt-get clean

EXPOSE 80

