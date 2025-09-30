#!/usr/bin/sh

set -e

# Load the configuration file.
source $(dirname $0)/config.sh

token=$(cat $TEMP_DIR/token)

for segment in $SEGMENT_DIR/*.txt; do
	text=$(cat $segment)
	encoded_text=$(jq -Rrs '@uri' $segment)
	audio=$(echo $segment | sed s/.txt$//g)

	echo "Training of the english expression '$text'..."
	curl -Ss -X 'POST' \
	  "$HOST/api/v1/train?text=$encoded_text&locale=en-US&agent_id=$AGENT_ID" \
	  -H 'accept: application/json' \
	  -H "Authorization: Bearer ${token}" \
	  -H 'Content-Type: multipart/form-data' \
	  -F "audios=@$audio;type=audio/mpeg" \
	  -F "audios=@$audio;type=audio/mpeg" \
	  -F "audios=@$audio;type=audio/mpeg" \
	  -F "audios=@$audio;type=audio/mpeg"
	echo ''
done
