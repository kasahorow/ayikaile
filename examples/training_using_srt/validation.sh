#!/usr/bin/sh

set -e

# Load the configuration file.
source $(dirname $0)/config.sh

if [ -z $1 ]; then
	echo audio path is not provided!
	exit 1
elif [ ! -f "$1" ]; then
	echo audio path is not a file!
	exit 1
else
	audio_path=$1
fi

echo "Authentication..."
token=$(curl -Ss -X 'POST' \
  "$HOST/token" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'username=test%40example.com&password=example' | jq -r '.access_token')

echo "Validation of ..."
curl -X 'POST' \
  "$HOST/api/v1/stt?language_code=en-US&min_confidence=0.6&min_break_time=1000&agent_id=$AGENT_ID" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer $token" \
  -H 'Content-Type: multipart/form-data' \
  -F "audio=@$audio_path;type=audio/mpeg"
echo ''
