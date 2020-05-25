### 2020/05 Michael Grate 

Automation to manage my Linux Dev Environment.

Ubuntu Prerequisites (or as root)
```
sudo apt-add-repository universe
sudo apt update
sudo apt install -y git ansible make
```

Manually, make sure your user is a sudoer

/etc/sudoers
```
username ALL=(ALL:ALL) ALL
```

Configure Git
```
git config --global user.email "your@email.com"
git config --global user.name "username"
```

Important: Be sure to update ./base/group_vars/all.yml user variable to match your username where automation will be ran.

