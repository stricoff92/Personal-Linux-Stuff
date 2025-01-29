
#!/bin/bash

# git add/commit/push all in one script

message="$1"

if [[ -z $message ]]; then
    message="wip"
fi

echo "committing with message \"$message\""

git add .
git commit -m "$message"
git push
