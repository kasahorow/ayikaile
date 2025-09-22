#!/usr/bin/sh

set -e

# Load the configuration file.
source $(dirname $0)/config.sh

echo "Authentication..."
token=$(curl -Ss -X 'POST' \
  "$HOST/token" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'username=test%40example.com&password=example' | jq -r '.access_token')

for segment in $SEGMENT_DIR/*.txt; do
	text=$(cat $segment)
	encoded_text=$(jq -Rrs '@uri' $segment)
	audio=$(echo $segment | sed s/.txt$//g)

	echo "Training of the english expression '$text'..."
	curl -Ss -X 'POST' \
	  "$HOST/api/v1/train?text=$encoded_text&language_code=en-US&agent_id=$AGENT_ID" \
	  -H 'accept: application/json' \
	  -H "Authorization: Bearer ${token}" \
	  -H 'Content-Type: multipart/form-data' \
	  -F "audios=@$audio;type=audio/mpeg" \
	  -F "audios=@$audio;type=audio/mpeg" \
	  -F "audios=@$audio;type=audio/mpeg" \
	  -F "audios=@$audio;type=audio/mpeg" | jq -e '.status == true'
	echo ''
done
