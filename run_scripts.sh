#!/bin/bash

device_id=""

if [ "$#" -eq 1 ]; then
    device_id=$1
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

function exit_script() {
    job=`eval "jobs -p -r"`
    echo "Killing PID $job"
    # kill $(jobs -p -r)
    # jobs -p -r | wc -l
    job_count=`eval "jobs -p -r | wc -l"`
    echo "Number of running jobs is $job_count"
    echo "Exiting run script"
}

function split_on_commas() {
    local IFS=,
    local WORD_LIST=($1)
    for word in "${WORD_LIST[@]}"; do
        echo "$word"
    done
}

function create_loop() {
    if [ "$#" -ne 3 ]; then
        echo "Usage: $0 <ttl> <cmd> <device_id>"
        exit 1
    fi

    ttl=$1
    cmds=$2
    device_id=$3

    while true
    do
        split_on_commas $cmds | while read item; do
            # Custom logic goes here
            echo $item $ttl $device_id
            source $item $ttl $device_id
        done
        
        echo "$ttl second loop"
        echo "---------------------"

        sleep $ttl
    done
}

zero=0
set -f

# Define ttl buckets
# 5 seconds
five_s_ttls=5
# 20 seconds
twenty_s_ttls=20
# 30 seconds
thirty_s_ttls=30
# 2 minutes
two_m_ttls=120
# 15 minutes
fifteen_m_ttls=900
# 30 minutes
thirty_m_ttls=1800
# 1 hour
one_h_ttls=3600
# 3 hours
three_h_ttls=10800
# 6 hours
six_h_ttls=21600
# 12 hours
twelve_h_ttls=43200
# 24 hours
tf_h_ttls=86400

# --------------------

# Generate webp file
db_run_cmd="./db_characters/run_script.sh"

# ----------
tech_news_run_cmd="./api_text/tech_news/run_script.sh"

# --------------------
# Push to Tydbyt and run in background with ttl and run script commands
# Multiple scripts in same ttl bucket example
# create_loop $two_m_ttls $db_run_cmd,$tech_news_run_cmd &
create_loop $two_m_ttls $db_run_cmd $device_id &
# create_loop $one_h_ttls $tech_news_run_cmd $device_id &

# --------------------

# Kill process when ctrl-c
trap exit_script INT
wait