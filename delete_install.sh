#!/bin/bash

# Get all tidbyt device IDs
device_id=""

if [ "$#" -eq 2 ]; then
    device_id=$2
fi

if [ -z "${device_id}" ]; then

    get_devices_command="pixlet devices"
    devices_str=$(eval "$get_devices_command")
    device_array=()

    while IFS= read -r device_str; do
        device_str_array=($device_str) # Strip device name
        device_array+=(${device_str_array[0]})
    done <<< "$devices_str"
    device_id="${device_array[0]}" # Just get the first device

    if [ -z "${device_id}" ]; then
        echo "Device ID not detected"
        exit
    fi
fi

if [ "$#" -ne 1 ] && [ "$#" -ne 2 ]; then
    echo "Delete apps by installation ID"
    echo "Usage: $0 <installation_id>"
    echo "Current installations"
    echo "AppID                   InstallationID"
    echo "--------------------------------------------"
    eval "pixlet list $device_id"
    exit 1
fi
installation_id=$1
echo "installation_id: $installation_id"

. ./tidbyt.config

api_key=$api_key

header_one="Authorization: Bearer $api_key"
header_two="Content-Type: application/json"

# Use API to push webp
url="https://api.tidbyt.com/v0/devices/$device_id/installations/$installation_id"
echo "url: $url"
curl_command="curl -X 'DELETE' '$url' --header \"$header_one\" --header \"$header_two\""
eval $curl_command 2>&1