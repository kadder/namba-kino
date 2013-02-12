#!/bin/sh
pkill -9 -f "kino"
nohup ruby kino.rb >> /tmp/kino.log 2>&1 &
