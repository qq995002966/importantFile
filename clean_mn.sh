#!/bin/sh

sudo mn -c
sudo killall behavioral-model
sudo redis-cli FLUSHALL
