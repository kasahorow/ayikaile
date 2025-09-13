#!/usr/bin/sh
set -e

# Loading the configuration file.
source $(dirname $0)/config.sh

lang_code=akan
audio=$DATA_PATH/combined.mp3
token=$(cat $(find $TEMP_DIR/*.token | head -n 1))

# Generate the test audio.
ffmpeg -y -safe 0 -f concat -i <(find $DATA_PATH/audio -type f | head -n 100 | xargs -i printf "file '`pwd`/{}'\n") $audio

echo "Validation of $audio..."
curl -X 'POST' \
  "$HOST/api/v1/stt?text=&language_code=$lang_code" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer $token" \
  -H 'Content-Type: multipart/form-data' \
  -F "audio=@$audio;type=audio/vnd.wave"
