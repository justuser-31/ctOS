cd run_tracker
git submodule init
git submodule update
musl-gcc rtracker.c -o rtracker
echo ''
echo 'DONE'