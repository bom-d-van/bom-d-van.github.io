#!/usr/bin/env bash

pandoc --standalone --template template.html bpftrace/go.md --metadata title='Using bpftrace on Go programs' -o bpftrace/go.html
pandoc --standalone --template template.html bpftrace/debug_osq_lock.md --metadata title='Debugging kernel cpu time with luck, unwinding perl stack with bpftrace' -o bpftrace/debug_osq_lock.html
pandoc --standalone --template template.html bpftrace/perldtrace.md --metadata title='Some bpftrace scripts using perldtrace' -o bpftrace/perldtrace.html
pandoc --standalone --template template.html to-glob-10m-metrics-using-trie-and-dfa/readme.md --metadata title='To glob 10M metrics: Trie * DFA = Tree² for Go-Carbon (the graphite storage node daemon)' -o to-glob-10m-metrics-using-trie-and-dfa/index.html

pandoc --standalone --template template_index.html readme.md --metadata title="Xiaofan Hu's blogs" -o index.html

# from markdown t o pdf/slides
# marp2 --pdf -o quota.pdf --allow-local-files quota.md
