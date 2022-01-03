#!/usr/bin/env bash

function gen_html {
	title="$1"
	markdown_file=$2
	html_file=$3
	pandoc --standalone --template template.html --metadata title="$title" -o $html_file $markdown_file
	cargo run $markdown_file
}

gen_html 'Using bpftrace on Go programs' bpftrace/go.md bpftrace/go.html
gen_html 'Debugging kernel cpu time with luck, unwinding perl stack with bpftrace' bpftrace/debug_osq_lock.md bpftrace/debug_osq_lock.html
gen_html 'Some bpftrace scripts using perldtrace' bpftrace/perldtrace.md bpftrace/perldtrace.html
gen_html 'To glob 10M metrics: Trie * DFA = Tree² for Go-Carbon (the graphite storage node daemon)' to-glob-10m-metrics-using-trie-and-dfa/readme.md to-glob-10m-metrics-using-trie-and-dfa/index.html

gen_html 'How to shrink whisper files for fun and profit' how-to-shrink-whisper-files/readme.md how-to-shrink-whisper-files/index.html

sed -i '' 's/<table>/<table class="table">/' how-to-shrink-whisper-files/index.html

pandoc --standalone --template template_index.html readme.md --metadata title="Xiaofan Hu's blogs" -o index.html

# from markdown t o pdf/slides
# marp2 --pdf -o quota.pdf --allow-local-files quota.md
