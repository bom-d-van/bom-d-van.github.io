
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

resume-cn:
	pandoc -f markdown -t html -o resume-cn.html --template template_resume.html resume-cn.md
	wkhtmltopdf resume-cn.html resume-cn.pdf
	open resume-cn.pdf

resume:
# 	pandoc -f markdown -t pdf -o resume.pdf resume.md
	pandoc -f markdown -t html -o resume.html --template template_resume.html resume.md
	wkhtmltopdf resume.html resume.pdf
	open resume.pdf

resume-merged:
	pandoc -f markdown -t html -o resume-en-merged.html resume.md
	pandoc -f markdown -t html -o resume-cn-merged.html resume-cn.md
	./merge_resume.sh > resume-merged.html
	wkhtmltopdf resume-merged.html resume-merged.pdf
	open resume-merged.pdf

# marp --pdf -o graphite-admin-and-quota.pdf --allow-local-files graphite-admin-and-quota.md && open graphite-admin-and-quota.pdf
