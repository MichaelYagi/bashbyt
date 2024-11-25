#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Delete apps by installation ID"
    echo "Usage: $0 <installation_id>"
    exit 1
fi
installation_id=$1
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
url="https://api.tidbyt.com/v0/devices/$device_id/installations/$installation_id"
echo "url: $url"
curl_command="curl -X 'DELETE' '$url' --header \"$header_one\" --header \"$header_two\""
eval $curl_command 2>&1