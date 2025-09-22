#!/usr/bin/sh
set -e

# Loading the configuration file.
source $(dirname $0)/config.sh

lang_code=akan
audio=$DATA_PATH/combined.mp3
token=$(find $TEMP_DIR/token | head -n 1)
agent_id=$(ls -1 $CLEANED_METADATA_PATH | head -n 1)
credential=$(cat $BASE/agent_credentials | head -n $agent_id | tail -n 1)

# Generate the test audio.
ffmpeg -y -safe 0 -f concat -i <(cat $CLEANED_METADATA_PATH/$agent_id/* | sort -R | head -n 100 | tee $DATA_PATH/combined.txt | cut -d , -f 1 | xargs -i printf "file `pwd`/'{}'\n") $audio

cat $DATA_PATH/combined.txt | cut -d , -f 2 | xargs -i printf '{} ' > $audio.original.txt

echo "Validation of $audio using $agent..."
curl -X 'POST' \
  "$HOST/api/v1/stt?language_code=$lang_code&min_confidence=0.7&min_break_time=500&agent_id=$credential" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer $(cat $token)" \
  -H 'Content-Type: multipart/form-data' \
  -F "audio=@$audio;type=audio/vnd.wave" | jq > $audio.predicted.json

echo The result is available at $(dirname $audio)
