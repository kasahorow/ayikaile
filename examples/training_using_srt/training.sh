#!/usr/bin/sh

set -e

# Load the configuration file.
source $(dirname $0)/config.sh

token=$(cat $TEMP_DIR/token)

curl -Ss -X 'POST' \
  "$HOST/api/v1/train_srt?locale=en-US&agent_id=$AGENT_ID" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer ${token}" \
  -H 'Content-Type: multipart/form-data' \
  -F "srt=@$DATA_DIR/audio.srt;type=application/x-subrip" \
  -F "audio=@$DATA_DIR/talking-female-vocals-i-don-t-think-i-understand-it_10bpm_F#_minor.mp3;type=audio/mpeg"
echo ''
