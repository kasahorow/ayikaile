#!/usr/bin/sh

set -e

# Load the configuration file.
source $(dirname $0)/config.sh

if [ -z "$@" ]; then
	echo Usage: program 'audio path' 'srt path'
elif [ $# -lt 2 ]; then
	echo audio path or srt path is not provided!
	exit 1
elif [ ! -f "$1" -o ! -f "$2" ]; then
	echo audio path or srt path is not a file!
	exit 1
else
	audio_path=$1
	srt_path=$2
fi

while true; do
	read sub_id || break;
	read sub_timestamp;
	sub_text="";

	# extract subtitle time info in milliseconds
	sub_timestamp=$(echo $sub_timestamp | sed -re 's/(\w*):(\w*):(\w*),(\w*)/`expr \\( \1 \\* 24 + \2 \\* 60 + \3 \\) \\* 1000 + \4`/g' -e 's/-->//g' -e 's/.*/echo &/e')
	sub_start=$(echo $sub_timestamp | cut -f 1 -d ' ')
	sub_end=$(echo $sub_timestamp | cut -f 2 -d ' ')
	sub_duration=$(expr $sub_end - $sub_start)
	
	# combine subtiltles
	while read text; do
		if [ -z "$text" ]; then break; fi
		sub_text="$sub_text$text "
	done

	# generate the segment name
	segment_name=${sub_start}_${sub_end}_$(basename $audio_path)

	# save the segment subtitle.
	echo -e $sub_text > $SEGMENT_DIR/$segment_name.txt

	# save the segment audio.
	sub_start_s=$(expr $sub_start / 1000 || echo).$(expr $sub_start % 1000 / 100 || echo)
	sub_duration_s=$(expr $sub_duration / 1000).$(expr $sub_duration % 1000 / 100 || echo)
	ffmpeg -y -i $audio_path -ss $sub_start_s -t $sub_duration_s $SEGMENT_DIR/$segment_name
done < $srt_path
