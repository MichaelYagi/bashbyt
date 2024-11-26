#!/bin/bash

# Render webp
# Argument validation check
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <ttl_seconds>"
    exit 1
fi
ttl_seconds=$1
render_command="pixlet render api_text/api_text.star debug_output=False ttl_seconds=$ttl_seconds api_url='https://newsapi.org/v2/top-headlines?country=us&apiKey=2c78e3ed7a664255833b80391cbb902d' request_headers="" base_url="" heading_response_path="articles,\[rand1\],title" body_response_path="articles,\[rand1\],description" image_response_path="articles,\[rand1\],urlToImage" image_placement=2 heading_font_color="FFA500" body_font_color="FFFFFF""
eval "$render_command"

mv api_text/api_text.webp api_text/tech_news/tech_news.webp

source ./base_push_script.sh "./api_text/tech_news/tech_news.webp" "technews"