#!/usr/bin/sh

set -e

# Loading the configuration file.
source $(dirname $0)/config.sh

auth_file=$TEMP_DIR/token
token=$(cat $TEMP_DIR/token)

for agent in $CLEANED_METADATA_PATH/*; do
	# Get agent credentials.
	credential=$(head -n $(basename $agent) $BASE/agent_credentials | tail -n 1)
	echo "Agent $credential"

	# Training the words of the agent.
	for agent_word in $agent/*; do
		word=$(basename $agent_word | cut -d '.' -f 1 | tr '_' ' ')
		encoded_word=$(echo -n $word | jq -Rrs @uri)

		echo "Training of the $LOCALE word '$word'..."

		cmd="
		curl -Ss -X 'POST' \
		'$HOST/api/v1/train?text=$encoded_word&locale=$LOCALE&agent_id=$credential' \
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
