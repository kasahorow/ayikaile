#!/usr/bin/sh

HOST='http://127.0.0.1:8000'
# HOST='https://ayikaile.kasahorow.com'

BASE=$(dirname $0)
DATA_DIR=$BASE/data
SEGMENT_DIR=$BASE/segments
# This represent an ayikaile subscription
AGENT_ID='0000000ce26285e0c7391752defe58577f0b527'

mkdir -p $SEGMENT_DIR
