#!/usr/bin/sh

set -e

BASE=$(dirname $0)
HOST='https://ayikaile.kasahorow.com'

echo "Authentication..."
token=$(curl -Ss -X 'POST' \
  "$HOST/token" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'username=test%40example.com&password=example' | jq -r '.access_token')

echo "Training of the akan word 'din'..."
curl -Ss -X 'POST' \
  "$HOST/api/v1/train?text=din&language_code=akan" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer ${token}" \
  -H 'Content-Type: multipart/form-data' \
  -F "audios=@${BASE}/data/din/din8.flac.mp3;type=audio/vnd.wave" \
  -F "audios=@${BASE}/data/din/din2.flac.mp3;type=audio/vnd.wave" \
  -F "audios=@${BASE}/data/din/din6.flac.mp3;type=audio/vnd.wave" \
  -F "audios=@${BASE}/data/din/din4.flac.mp3;type=audio/vnd.wave" \
  -F "audios=@${BASE}/data/din/din9.flac.mp3;type=audio/vnd.wave" \
  -F "audios=@${BASE}/data/din/din7.flac.mp3;type=audio/vnd.wave" \
  -F "audios=@${BASE}/data/din/din3.flac.mp3;type=audio/vnd.wave" \
  -F "audios=@${BASE}/data/din/din5.flac.mp3;type=audio/vnd.wave"
echo ''

echo "Training of the english word 'hello'..."
curl -Ss -X 'POST' \
  "$HOST/api/v1/train?text=hello&language_code=english" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer ${token}" \
  -H 'Content-Type: multipart/form-data' \
  -F "audios=@${BASE}/data/hello/hello_en-US_OliviaV3Voice.mp3;type=audio/vnd.wave" \
  -F "audios=@${BASE}/data/hello/hello_en-US_HenryV3Voice.mp3;type=audio/vnd.wave" \
  -F "audios=@${BASE}/data/hello/hello_en-GB_CharlotteV3Voice.mp3;type=audio/vnd.wave" \
  -F "audios=@${BASE}/data/hello/hello_en-GB_KateV3Voice.mp3;type=audio/vnd.wave" \
  -F "audios=@${BASE}/data/hello/hello_en-US_AllisonV3Voice.mp3;type=audio/vnd.wave" \
  -F "audios=@${BASE}/data/hello/hello_en-US_MichaelV3Voice.mp3;type=audio/vnd.wave"
echo ''

echo "Testing of the akan word 'din' to english..."
curl -X 'POST' \
  "$HOST/api/v1/stt?text=&language_code=english" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer $token" \
  -H 'Content-Type: multipart/form-data' \
  -F "audio=@${BASE}/data/din/din.flac.mp3;type=audio/vnd.wave"
echo ''

echo "Testing of the english word 'hello' to akan..."
curl -X 'POST' \
  "$HOST/api/v1/stt?text=&language_code=akan" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer $token" \
  -H 'Content-Type: multipart/form-data' \
  -F "audio=@${BASE}/data/hello/hello_en-GB_JamesV3Voice.mp3;type=audio/vnd.wave"
echo ''
