# GNU/LINUX Bash Scripts

This readme contains configurations for my own personal debian environment. It contains a few IDs that are specific to me.


<img src="https://media1.tenor.com/m/y-cCxl8uEw0AAAAC/yetopen.gif" width="180px">

```bash
# Manage firewalls

sudo ufw enable
sudo ufw default deny incoming
sudo ufw allow from 192.168.1.0/24 to 0.0.0.0/0 port 22


# Disable "Super + p" shortcut
gsettings get org.gnome.mutter.keybindings switch-monitor
# expected output: ['<Super>p', 'XF86Display']

# disable shortcut
gsettings set org.gnome.mutter.keybindings switch-monitor "['XF86Display']"


# add poweroff & reboot to path
sudo ln -s /usr/sbin/poweroff /usr/bin/
sudo ln -s /usr/sbin/reboot /usr/bin/
```

```bash
# Disable "Super + p" shortcut
gsettings get org.gnome.mutter.keybindings switch-monitor
# expected output: ['<Super>p', 'XF86Display']

gsettings set org.gnome.mutter.keybindings switch-monitor "['XF86Display']"
```

```bash
# .bash_profile/.bashrc

## git shortcuts
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

```

```bash
# .bash_aliases

alias gitaa='git add .; git commit -m wip; git push;'
alias git-='git checkout -'
alias gitpsu='git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)'
alias envup='souce env/bin/activate'
alias aliasup='source .bash_aliases'

```

```bash
# Add process filtering program to PATH
sudo cat psfilt.sh > /usr/local/bin/psfilt
chmod +x /usr/local/bin/psfilt
```

```bash
# Remove Discord's default minumum Window Size

cat | python3 <<EOL
import json, os
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


# archive
```bash
# fstab
UUID="41fec3a1-54cd-46cd-980a-05cfa160a3c1" /media/jon/archive ext4 defaults,nofail                      0 0
```

# backup
```bash

# copy to external media
rsync \
    --exclude .cache \
    --exclude .config \
    --exclude .local \
    --exclude .jupyter \
    --exclude .mozilla \
    --exclude .npm \
    --exclude .nvm \
    --exclude .steam \
    --exclude .thunderbird/ \
    --exclude .var \
    --exclude .vscode \
    --exclude .zoom \
    --exclude env \
    --exclude node_modules \
    --exclude Downloads \
    -av /home/$USER/ /media/$USER/archive/$(hostname)_$(hostnamectl | grep -i 'Machine ID' | awk '{ print $3 }')/

# compress to tar.gz
CUR_DATE="`date +"%d-%m-%Y"`"
tar -czvf "bak_$CUR_DATE.tar.gz" /media/$USER/archive/$(hostname)_$(hostnamectl | grep -i 'Machine ID' | awk '{ print $3 }')/

# encrypt with password
gpg -c "bak_$CUR_DATE.tar.gz"
```

# Customize Login Screen
```bash
sudo cat <<EOT >> /etc/dconf/db/gdm.d/00-login-screen
[org/gnome/login-screen]
# Do not show the user list
disable-user-list=true
banner-message-enable=true
banner-message-text='hello, friend'
logo='/usr/share/pixmaps/image.png'
EOT
sudo dconf update

# or edit /etc/gdm3/greeter.dconf-defaults
```

# C app types (gcc)
```c
#include <stdint.h>

typedef uint8_t     u8;
typedef int8_t      i8;
typedef uint16_t    u16;
typedef int16_t     i16;
typedef uint32_t    u32;
typedef int32_t     i32;
typedef uint64_t    u64;
typedef int64_t     i64;
typedef float       f32;
typedef double      f64;

#define U8(v)  ((u8)(v))
#define I8(v)  ((i8)(v))
#define U16(v) ((u16)(v))
#define I16(v) ((i16)(v))
#define U32(v) ((u32)(v))
#define I32(v) ((i32)(v))
#define U64(v) ((u64)(v))
#define I64(v) ((i64)(v))
#define F32(v) ((f32)(v))
#define F64(v) ((f64)(v))

#define typedef_packed_struct typedef struct __attribute__((packed))
```
