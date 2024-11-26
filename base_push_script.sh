#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <path_to_webp>"
    echo "$1 <installation_id>"
    exit 1
fi
path_to_webp=$1
installation_id=$2

echo "path_to_webp: $path_to_webp"
echo "installation_id: $installation_id"

. ./tidbyt.config

api_key=$api_key
header_one="Authorization: Bearer $api_key"
header_two="Content-Type: application/json"

# Get all tidbyt device IDs
get_devices_command="pixlet devices"
devices_str=$(eval "$get_devices_command")
device_array=()

while IFS= read -r device_str; do
    device_str_array=($device_str) # Strip device name
    device_array+=(${device_str_array[0]})
done <<< "$devices_str"

# Use API to push webp
device_id="${device_array[0]}"

# Through API endpoint
url="https://api.tidbyt.com/v0/devices/$device_id/push"
b64=$(cat $path_to_webp | base64)
b64="${b64//$'\n'/}"
b64="${b64//$''/}"

# curl_command="curl --header \"$header_one\" --header \"$header_two\" -v \"$url\" -d '{\"image\":\"$b64\",\"installationID\":\"$installation_id\",\"background\":true}'"

# Ensure data isn't too long for command
echo "{\"installationID\": \"$installation_id\",\"background\":true,\"image\": \"$b64\"}" > /tmp/data.json
curl_command="curl --header \"$header_one\" --header \"$header_two\" -v \"$url\" -d @/tmp/data.json"
eval $curl_command

# Through Pixlet command doesn't play full animation
# pixlet_command="pixlet push --installation-id $installation_id \"$device_id\" $path_to_webp"
# eval $pixlet_command
