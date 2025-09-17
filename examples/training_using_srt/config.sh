#!/usr/bin/sh

HOST='http://127.0.0.1:8000'
# HOST='https://ayikaile.kasahorow.com'

BASE=$(dirname $0)
DATA_DIR=$BASE/data
SEGMENT_DIR=$BASE/segments

mkdir -p $SEGMENT_DIR
