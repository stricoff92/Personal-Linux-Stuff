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
