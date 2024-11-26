#!/bin/bash

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
    if [ "$#" -ne 2 ]; then
        echo "Usage: $0 <ttl> <cmd>"
        exit 1
    fi

    ttl=$1
    cmds=$2

    while true
    do
        split_on_commas $cmds | while read item; do
            # Custom logic goes here
            echo $item $ttl
            source $item $ttl
        done
        
        echo "2m loop"

        sleep $ttl
    done
}

zero=0
set -f

# Define ttl buckets
five_s_ttls=5
twenty_s_ttls=20
thirty_s_ttls=30
two_m_ttls=120
fifteen_m_ttls=900
thirty_m_ttls=1800
one_h_ttls=3600

# --------------------

# Pass ttl in seconds
# Generate webp file
db_run_cmd="./db_characters/run_script.sh"

# ----------
tech_news_run_cmd="./api_text/tech_news/run_script.sh"

# --------------------
# Push to Tydbyt and run in background
create_loop $two_m_ttls $db_run_cmd,$tech_news_run_cmd &
# create_loop $two_m_ttls $db_run_cmd &

# ----------

# Test
# test_loop() {
#     while true
#     do
#         echo "test"
#         sleep 2
#         
#     done
# }

# # Run in background
# test_loop &

# --------------------

# Kill process when ctrl-c
trap exit_script INT
wait