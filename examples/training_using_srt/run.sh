#!/usr/bin/sh

set -e

# Load the configuration file.
source $(dirname $0)/config.sh 

echo "Start the audio chunk extractor..."
bash -i $BASE/extractor.sh $DATA_DIR/talking-female-vocals-i-don-t-think-i-understand-it_10bpm_F#_minor.mp3 $DATA_DIR/audio.srt

echo "Start the training..."
bash $BASE/training.sh

echo "Start the validation..."
bash $BASE/validation.sh $DATA_DIR/talking-female-vocals-i-don-t-think-i-understand-it_10bpm_F#_minor.mp3
