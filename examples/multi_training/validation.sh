#!/usr/bin/sh
set -e

# Loading the configuration file.
source $(dirname $0)/config.sh

lang_code=akan
audio=$(find $DATA_PATH/audio/*/*/*.wav | head -n 1)
token=$(cat $(find $TEMP_DIR/*.token | head -n 1))

curl -X 'POST' \
  "$HOST/api/v1/stt?text=&language_code=$lang_code" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer $token" \
  -H 'Content-Type: multipart/form-data' \
  -F "audio=@$audio;type=audio/vnd.wave"
