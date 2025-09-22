#!/usr/bin/sh

set -e

# Loading the configuration file.
source $(dirname $0)/config.sh

auth_file=$TEMP_DIR/token
echo "Authentication of $KASAHOROW_EMAIL..."
token=$(curl -Ss -X 'POST' \
  "$HOST/token" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d "username=$KASAHOROW_EMAIL&password=$KASAHOROW_CONSENT_CODE" | jq -r '.access_token')
echo $token > $auth_file

for agent in $CLEANED_METADATA_PATH/*; do
	# Get agent credentials.
	credential=$(head -n $(basename $agent) $BASE/agent_credentials | tail -n 1)

	# Training the words of the agent.
	for agent_word in $agent/*; do
		word=$(basename $agent_word | cut -d '.' -f 1 | tr '_' ' ')
		encoded_word=$(echo -n $word | jq -Rrs @uri)
		lang_code=yemba

		echo "Training of the $lang_code word '$word'..."

		cmd="
		curl -Ss -X 'POST' \
		'$HOST/api/v1/train?text=$encoded_word&language_code=$lang_code&agent_id=$credential' \
		  -H 'accept: application/json' \
		  -H 'Authorization: Bearer $token' \
		  -H 'Content-Type: multipart/form-data' \
		"

		while read audio; do
			cmd="$cmd
			-F 'audios=@$(echo $audio | cut -d , -f 1);type=audio/vnd.wave' \
			"
		done < $agent_word

		# Add 03 duplicates to ensure we respect model restriction.
		d=$(echo $cmd | xargs -d ' ' -i echo {} | tail -n 3 | tr '\n' ' ')
		cmd="$cmd $d $d $d"

		eval $cmd | jq -er '.status'
	done	
done
