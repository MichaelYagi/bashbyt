#!/bin/bash

# Render webp
# Argument validation check
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <ttl_seconds> <device_id>"
    exit 1
fi
ttl_seconds=$1
device_id=$2
render_command="pixlet render ./db_characters/db_characters.star debug_output=False show_headshot=False ttl_seconds=$ttl_seconds line_one_color="FFFFFF" line_two_color="FFFFFF" line_three_color="FFFFFF" line_four_color="FFFFFF" line_five_color="FFFFFF""
eval "$render_command"

# Push webp with installationID
source ./base_push_script.sh "./db_characters/db_characters.webp" "dbcharacters" "$device_id"