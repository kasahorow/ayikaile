#!/usr/bin/bash

echo 'In this example, we generate the pronunciation of the Ghomala word `ghɔ̀`.'
curl 'https://api.woaka.com/tts?text=gh%C9%94%CC%80&kasa=bai-bbj&access=BKjXRBGX' -o /tmp/audio.wav
play /tmp/audio.wav
