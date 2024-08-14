# LINUX / BASH scripts

This readme contains configurations for my own personal debian environment. It may contain IDs that are specific to me.

<img src="https://media1.tenor.com/m/y-cCxl8uEw0AAAAC/yetopen.gif" width="180px">

```bash
# Manage firewalls

sudo ufw enable
sudo ufw default deny incoming
sudo ufw allow from 192.168.1.0/24 to 0.0.0.0/0 port 22
```

```bash
# .bash_profile/.bashrc

## git shortcuts
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "
alias gitaa='git add .; git commit -m wip; git push;'
alias git-='git checkout -'
alias gitpsu='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'

## for the lols
alias matrix='cmatrix -bas'
cmatrix -bas
```
```bash
# Remove Discord's default minumum Window Size

cat | python3 <<EOL
import json, os

# uncomment one of these
# cfg_file = os.path.join(os.environ['HOME'], '.config/discord/settings.json') # .deb
cfg_file = os.path.join(os.environ['HOME'], '.var/app/com.discordapp.Discord/config/discord/settings.json') # flatpak

with open(cfg_file) as f:
    cfg_data = json.load(f)
cfg_data['MIN_WIDTH'] = 0
cfg_data['MIN_HEIGHT'] = 0
with open(cfg_file, 'w') as f:
    json.dump(cfg_data, f, indent=2)
print(f"{cfg_file} updated")
EOL
```

```bash
# Animated Terminal clock

#!/bin/bash
# place in /usr/local/bin/tclock

COLORSEED=1;
getdate() {
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
# archive
```bash
# fstab
UUID="41fec3a1-54cd-46cd-980a-05cfa160a3c1" /media/jon/archive ext4 defaults,nofail                      0 0
```

# backup
```bash
rsync \
    --exclude .cache/ \
    --exclude .local \
    --exclude .steam \
    --exclude .vscode \
    --exclude .thunderbird/ \
    --exclude .var \
    --exclude .config \
    --exclude .nvm \
    --exclude .npm \
    --exclude .mozilla \
    --exclude .jupyter \
    --exclude .zoom \
    --exclude env \
    -av /home/$USER/ /media/$USER/archive/$(hostname)_$(hostnamectl | grep -i 'Machine ID' | awk '{ print $3 }')/
```
