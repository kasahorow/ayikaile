#!/usr/bin/bash

set -e

# Loading the configuration file.
source $(dirname $0)/config.sh

# Downloading of the dataset.
# https://data.mendeley.com/datasets/74p9d5frg3/2
pushd $TEMP_DIR
wget -c https://prod-dcd-datasets-cache-zipfiles.s3.eu-west-1.amazonaws.com/74p9d5frg3-2.zip
unzip -o 74p9d5frg3-2.zip
popd

# Moving the data
rm -rf $DATA_PATH
mkdir $DATA_PATH
mv $TEMP_DIR/YembaEGRA/YembaEGRA/* $DATA_PATH
