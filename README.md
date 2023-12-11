# .bash_profile/.bashrc

```bash
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

alias gitaa='git add .; git commit -m wip; git push;'
alias profile='vim ~/.bashrc'
alias git-='git checkout -'


```


# Animated Terminal clock
```bash
#!/bin/bash

# /usr/local/bin/tclock

COLORSEED=1;
function getdate {
    python3 -c "import datetime as dt; print(dt.datetime.now().strftime('%a %b %d %H:%M:%S'))"
}
while true; do
    if [ "$COLORSEED" -ge "10000000" ]; then
        COLORSEED=1
    else
        COLORSEED=$(( $COLORSEED + 2 ))
    fi
    getdate | lolcat -S $COLORSEED;
    sleep 0.02;
done
```
