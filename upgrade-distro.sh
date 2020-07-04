#!/bin/bash
apt-get -y update && \
apt-get -y upgrade && \
apt-get -y full-upgrade && \
apt-get -y autoclean && \
apt-get -y autoremove
