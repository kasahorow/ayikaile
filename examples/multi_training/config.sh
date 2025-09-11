#!/usr/bin/sh

set -e

BASE=$(dirname $0)
HOST='https://ayikaile.kasahorow.com'
HOST='http://127.0.0.1:8000'
DATA_PATH=$BASE/datasets
CLEANED_METADATA_PATH=$DATA_PATH/cleaned_metadata
TEMP_DIR=$BASE/.temp

mkdir -p $TEMP_DIR 
