#!/usr/bin/env bash

pandoc --standalone --template template.html bpftrace/go.md --metadata title='Using bpftrace on Go programs' -o bpftrace/go.html

pandoc --standalone --template template.html readme.md --metadata title="Xiaofan Hu's blogs" -o index.html
