#!/bin/bash

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <path_to_webp> <installation_id> <device_id>"
    exit 1
fi
path_to_webp=$1
installation_id=$2
device_id=$3

echo "path_to_webp: $path_to_webp"
echo "installation_id: $installation_id"

# Through API endpoint - doesn't play full animation
. ./tidbyt.config
api_key=$api_key
header_one="Authorization: Bearer $api_key"
header_two="Content-Type: application/json"
url="https://api.tidbyt.com/v0/devices/$device_id/push"
b64=$(cat $path_to_webp | base64)
b64="${b64//$'\n'/}"
b64="${b64//$''/}"
# Ensure data isn't too long for command using file
echo "{\"installationID\": \"$installation_id\",\"background\":true,\"image\": \"$b64\"}" > /tmp/data.json
curl_command="curl --header \"$header_one\" --header \"$header_two\" -v \"$url\" -d @/tmp/data.json"
eval $curl_command

# Through Pixlet command - doesn't play full animation - no ability to run in background
# pixlet_command="pixlet push --installation-id $installation_id \"$device_id\" $path_to_webp"
# eval $pixlet_command
