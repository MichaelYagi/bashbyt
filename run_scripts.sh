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

zero=0
set -f

# --------------------
# db_characters

five_s_ttls=5
twenty_s_ttls=20
thirty_s_ttls=30
two_m_ttls=120
fifteen_m_ttls=900
thirty_m_ttls=1800
one_h_ttls=3600

# Run each script for duration consecutively
# Pass ttl in seconds
# Generate webp file
db_run_cmd="./db_characters/run_script.sh $two_m_ttls"

# --------------------
# Run each script for duration consecutively
tech_news_run_cmd="./api_text/tech_news/run_script.sh $two_m_ttls"

# Run all commands before updating on a schecule
# source $tech_news_run_cmd
source $db_run_cmd

# --------------------
# Push to Tydbyt

# 2 minute bucket
two_m_loop() {
    while true
    do
        sleep $two_m_ttls

        # source $tech_news_run_cmd
        source $db_run_cmd

        echo "2m loop"
    done
}

# Run in background
two_m_loop &

# ----------

# Test
# test_loop() {
#     while true
#     do
#         sleep 2
#         echo "test"

#         # break
#     done
# }

# # Run in background
# test_loop &

# --------------------

# Kill process when ctrl-c
trap exit_script INT
wait