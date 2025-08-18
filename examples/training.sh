#!/usr/bin/sh

set -e

BASE=$(dirname $0)
HOST='https://ayikaile.kasahorow.com'

echo "Authentication..."
token=$(curl -Ss -X 'POST' \
  "$HOST/token" \
  -H 'accept: application/json' \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  -d 'username=example%40ayikaile.com&password=example' | jq -r '.access_token')

echo "Training of akia (a graduated ruler)..."
curl -Ss -X 'POST' \
  "$HOST/api/v1/train?text=akia" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer ${token}" \
  -H 'Content-Type: multipart/form-data' \
  -F "audios=@${BASE}/data/akia/spkr_37_word_23_occ_2_ci_3_l_3.wav;type=audio/vnd.wave" \
  -F "audios=@${BASE}/data/akia/spkr_14_word_23_occ_2_ci_3_l_3.wav;type=audio/vnd.wave" \
  -F "audios=@${BASE}/data/akia/spkr_10_word_23_occ_2_ci_3_l_3.wav;type=audio/vnd.wave" \
  -F "audios=@${BASE}/data/akia/spkr_17_word_23_occ_2_ci_3_l_3.wav;type=audio/vnd.wave"
echo ''

echo "Training of Atsá’ (the earth)..."
curl -Ss -X 'POST' \
  "$HOST/api/v1/train?text=atsa%CC%81%E2%80%99" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer ${token}" \
  -H 'Content-Type: multipart/form-data' \
  -F "audios=@${BASE}/data/atsa/spkr_65_word_57_occ_2_ci_8_l_3.wav;type=audio/vnd.wave" \
  -F "audios=@${BASE}/data/atsa/spkr_18_word_57_occ_2_ci_8_l_3.wav;type=audio/vnd.wave" \
  -F "audios=@${BASE}/data/atsa/spkr_12_word_57_occ_2_ci_8_l_3.wav;type=audio/vnd.wave" \
  -F "audios=@${BASE}/data/atsa/spkr_25_word_57_occ_2_ci_8_l_3.wav;type=audio/vnd.wave"
echo ''

echo "Testing akia..."
curl -X 'POST' \
  "$HOST/api/v1/stt" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer $token" \
  -H 'Content-Type: multipart/form-data' \
  -F "audio=@${BASE}/data/akia/spkr_33_word_23_occ_2_ci_3_l_3.wav;type=audio/vnd.wave"
echo ''

echo "Testing atsa..."
curl -X 'POST' \
  "$HOST/api/v1/stt" \
  -H 'accept: application/json' \
  -H "Authorization: Bearer $token" \
  -H 'Content-Type: multipart/form-data' \
  -F "audio=@${BASE}/data/atsa/spkr_11_word_57_occ_2_ci_8_l_3.wav;type=audio/vnd.wave"
echo ''
