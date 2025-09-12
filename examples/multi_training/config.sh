#!/usr/bin/sh

set -e

# Script home.
BASE=$(dirname $0)

# API host address.
# HOST='http://127.0.0.1:8000'
HOST='https://ayikaile.kasahorow.com'

# Data location.
DATA_PATH=$BASE/datasets
CLEANED_METADATA_PATH=$DATA_PATH/cleaned_metadata

# Temporary data location.
TEMP_DIR=$BASE/.temp

mkdir -p $TEMP_DIR 
