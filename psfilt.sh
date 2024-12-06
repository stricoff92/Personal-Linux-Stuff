
#!/bin/bash

# A simple script to filter ps output by process name, show the first match
# and display the output with 1 value per line.

# example output use
# foo@ra ~ $ psfilt apc

# USER		foo
# PID		67984
# %CPU		1.1
# %MEM		0.0
# VSZ		3756
# RSS		2644
# TTY		pts/0
# STAT		S+
# START		15:52
# TIME		0:17
# COMMAND   /home/foo/bar/build/apc


# CLI arg 1: process name to filter for
filtervalue=$1

headers=$(ps aux | head -n1)
data=$(ps aux | grep $filtervalue | grep -v grep | head -n1)

ix=1
for header in $headers; do
    printf "%s\t\t%s\n" "$header" "$(echo $data | awk '{print $'$ix'}')"
    ix=$((ix+1))
done
