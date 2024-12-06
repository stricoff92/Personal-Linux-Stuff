
#!/bin/bash

# A simple script to filter ps output by process name, and also show headers

# CLI arg 1: process name to filter for
filtervalue=$1

headers=$(ps aux | head -n1)
data=$(ps aux | grep $filtervalue | grep -v grep | head -n1)

ix=1
for header in $headers; do
    printf "%s\t\t%s\n" "$header" "$(echo $data | awk '{print $'$ix'}')"
    ix=$((ix+1))
done
