#!/usr/bin/sh

set -e

# Load the configuration file.
source $(dirname $0)/config.sh 

echo "Authentication..."
curl -Ss -X 'POST' \
  "$HOST/token" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'username=test%40example.com&password=example' | jq -r '.access_token' > $TEMP_DIR/token

echo "Start the training..."
bash $BASE/training.sh

echo "Start the validation..."
bash $BASE/validation.sh $DATA_DIR/talking-female-vocals-i-don-t-think-i-understand-it_10bpm_F#_minor.mp3
