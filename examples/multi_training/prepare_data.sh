#!/usr/bin/bash

set -e

# Loading the configuration file.
source $(dirname $0)/config.sh

# Prepare a clean metadata file.
rm -rf $CLEANED_METADATA_PATH
mkdir -p $CLEANED_METADATA_PATH

for audio in $DATA_PATH/audio/*/*/*.wav; do
    # Extracting metadata.
    # speaker word occ
    metadata=$(echo $audio | sed 's/.*\/spkr_\(\w*\)_word_\(\w*\)_occ.*.wav/\1 \2/g')

    speaker=$(echo $metadata | cut -d ' ' -f 1)
    # +1 because 0 is not wanted
    speaker=$(expr $speaker + 1)
    word_id=$(echo $metadata | cut -d ' ' -f 2)
    word=$(head -n $(expr $word_id + 1) $DATA_PATH/metadata/words_corpus\ .csv | tail -n 1 | cut -d ',' -f 2)

    # Generate the metadata of the speaker word audios.
    output_dir=$CLEANED_METADATA_PATH/$speaker
    mkdir -p $output_dir
    output=$output_dir/$(echo $word | tr ' ' '_')

    echo -n .
    echo $audio >> $output
done
