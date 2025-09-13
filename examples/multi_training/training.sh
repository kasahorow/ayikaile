#!/usr/bin/sh

set -e

# Loading the configuration file.
source $(dirname $0)/config.sh

# Cleaning
rm -rf $TEMP_DIR/*.token

for agent in $CLEANED_METADATA_PATH/*; do
	# Get agent credentials.
	credential=$(head -n $(basename $agent) $BASE/agent_credentials | tail -n 1)
	email=$(echo $credential | cut -d ' ' -f 1)
	consent_code=$(echo $credential | cut -d ' ' -f 2)

	# Authentificate if not yet.
	auth_file=$TEMP_DIR/$email.token
	if [ ! -f $auth_file ]; then
		echo "Authentication of $email..."
		token=$(curl -Ss -X 'POST' \
		  "$HOST/token" \
		  -H 'accept: application/json' \
		  -H 'Content-Type: application/x-www-form-urlencoded' \
		  -d "username=$email&password=$consent_code" | jq -r '.access_token')
		echo $token > $auth_file
	else
		token=$(cat $auth_file)
	fi

	# Training the words of the agent.
	for agent_word in $agent/*; do
		word=$(basename $agent_word | cut -d '.' -f 1 | tr '_' ' ')
		encoded_word=$(echo -n $word | jq -Rrs @uri)
		lang_code=yemba

		echo "Training of the $lang_code word '$word'..."

		cmd="
		curl -Ss -X 'POST' \
		'$HOST/api/v1/train?text=$encoded_word&language_code=$lang_code' \
		  -H 'accept: application/json' \
		  -H 'Authorization: Bearer $token' \
		  -H 'Content-Type: multipart/form-data' \
		"

		while read audio; do
			cmd="$cmd
			-F 'audios=@$audio;type=audio/vnd.wave' \
			"
		done < $agent_word

		# Add 03 duplicates to ensure we respect model restriction.
		d=$(echo $cmd | xargs -d ' ' -i echo {} | tail -n 3 | tr '\n' ' ')
		cmd="$cmd $d $d $d"

		eval $cmd | jq -er '.status'
	done	
done
