
all: index.html \
     bpftrace/go.html \
     bpftrace/debug_osq_lock.html \
     bpftrace/perldtrace.html \
     to-glob-10m-metrics-using-trie-and-dfa/index.html \
     how-to-shrink-whisper-files/index.html \
     ctrie/ctrie.html

bpftrace/go.html: bpftrace/go.md
	./gen.sh 'Using bpftrace on Go programs' bpftrace/go.md bpftrace/go.html

bpftrace/debug_osq_lock.html: bpftrace/debug_osq_lock.md
	./gen.sh 'Debugging kernel cpu time with luck, unwinding perl stack with bpftrace' bpftrace/debug_osq_lock.md bpftrace/debug_osq_lock.html

bpftrace/perldtrace.html: bpftrace/perldtrace.md
	./gen.sh 'Some bpftrace scripts using perldtrace' bpftrace/perldtrace.md bpftrace/perldtrace.html

to-glob-10m-metrics-using-trie-and-dfa/index.html: to-glob-10m-metrics-using-trie-and-dfa/readme.md
	./gen.sh 'To glob 10M metrics: Trie * DFA = Tree² for Go-Carbon (the graphite storage node daemon)' to-glob-10m-metrics-using-trie-and-dfa/readme.md to-glob-10m-metrics-using-trie-and-dfa/index.html

how-to-shrink-whisper-files/index.html: how-to-shrink-whisper-files/readme.md
	./gen.sh 'How to shrink whisper files for fun and profit' how-to-shrink-whisper-files/readme.md how-to-shrink-whisper-files/index.html

ctrie/ctrie.html: ctrie/ctrie.md
	./gen.sh 'Making The Trie Index And DFA Query Concurrent/Realtime' ctrie/ctrie.md ctrie/ctrie.html

index.html: readme.md
	pandoc --standalone --template template_index.html readme.md --metadata title="Xiaofan Hu's blogs" -o index.html

# marp --pdf -o graphite-admin-and-quota.pdf --allow-local-files graphite-admin-and-quota.md && open graphite-admin-and-quota.pdf
