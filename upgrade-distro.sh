#!/bin/bash
 apt-get -y update && \
 apt-get -y upgrade && \
 apt-get -y autoclean && \
 apt-get -y autoremove && \
 cp ./files/buster_sources.list /etc/apt/sources.list &&\
 apt-get -y update && \
 apt-get -y upgrade && \
 apt-get -y autoclean && \
 apt-get -y autoremove && \
 cp ./files/bullseye_sources.list /etc/apt/sources.list &&\
 apt-get -y update && \
 apt-get -y upgrade && \
 apt-get -y full-upgrade && \
 apt-get -y autoclean && \
 apt-get -y autoremove
