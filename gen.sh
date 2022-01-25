#!/usr/bin/env bash

title="$1"
markdown_file=$2
html_file=$3

# generate TOC
cargo run $markdown_file

# convert to html
pandoc --standalone --template template.html --metadata title="$title" -o $html_file $markdown_file

# handle tables
sed -i '' 's/<table>/<table class="table">/' $html_file
