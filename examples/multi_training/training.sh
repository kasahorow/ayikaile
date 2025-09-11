#!/usr/bin/sh

set -e

# Loading the configuration file.
source $(dirname $0)/config.sh

# Cleaning
rm -rf $TEMP_DIR/*.token

# TODO: REMOVE ME
limit_speaker=0

for speaker in $CLEANED_METADATA_PATH/*; do
	# TODO: REMOVE ME
	limit_speaker=`expr $limit_speaker + 1`
	if [ $limit_speaker -gt 2 ]; then break; fi

	# Get speaker auth.
	username=speaker$(basename $speaker)%40example.com
	password=pass

	# Authentificate if not yet.
	auth_file=$TEMP_DIR/$username.token
	if [ ! -f $auth_file ]; then
		echo "Authentication of $username..."
		token=$(curl -Ss -X 'POST' \
		  "$HOST/token" \
		  -H 'accept: application/json' \
		  -H 'Content-Type: application/x-www-form-urlencoded' \
		  -d "username=$username&password=$password" | jq -r '.access_token')
		echo $token > $auth_file
	else
		token=$(cat $auth_file)
	fi

	# TODO: REMOVE ME
	limit_word=0

	# Training the words of the speaker.
	for speaker_word in $speaker/*; do
		# TODO: REMOVE ME
		limit_word=`expr $limit_word + 1`
		if [ $limit_word -gt 2 ]; then break; fi

		word=$(basename $speaker_word | cut -d '.' -f 1 | tr '_' ' ')
		encoded_word=$(echo -n $word | jq -Rrs @uri)
		lang_code=todo

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
		done < $speaker_word

		eval $cmd | jq -er '.status'
	done	
done
