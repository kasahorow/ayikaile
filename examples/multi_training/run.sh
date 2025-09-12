#!/usr/bin/bash

set -e

# Loading the configuration file.
source $(dirname $0)/config.sh

echo "Downloading of the dataset..."
bash $(dirname $0)/download_data.sh
echo "Preparation of the dataset..."
bash $(dirname $0)/prepare_data.sh
echo "Training..."
bash $(dirname $0)/training.sh
echo "Validation..."
bash $(dirname $0)/validation.sh
