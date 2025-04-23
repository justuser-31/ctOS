shopt -s expand_aliases
alias rt="./rtracker"

rt "[RUN]: RUNNING ctOS ON QEMU..." \
	%% qemu-system-x86_64 -hda boot.img
