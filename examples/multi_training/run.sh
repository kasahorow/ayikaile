#!/usr/bin/bash

set -e

# Loading the configuration file.
source $(dirname $0)/config.sh

echo "Downloading of the dataset..."
bash $(dirname $0)/download_data.sh
echo "Preparation of the dataset..."
bash $(dirname $0)/prepare_data.sh
echo "Authentication of $KASAHOROW_EMAIL..."
curl -Ss -X 'POST' \
  "$HOST/token" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d "username=$KASAHOROW_EMAIL&password=$KASAHOROW_CONSENT_CODE" | jq -r '.access_token' > $TEMP_DIR/token
echo "Training..."
bash $(dirname $0)/training.sh
echo "Validation..."
bash $(dirname $0)/validation.sh
