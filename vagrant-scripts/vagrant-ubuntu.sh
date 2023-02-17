#!/bin/bash

########setting system information###############
# this shell is excute by root user.
# change vagrant user password
echo vagrant:123456 | chpasswd
echo root:123456 | chpasswd

# setting permit root login yes
echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
systemctl restart sshd

# setting system time zone
sudo timedatectl set-timezone Asia/Chongqing

## seting sources.list content with aliyun.com
#cat > /etc/apt/sources.list <<EOF
#deb http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
#deb-src http://mirrors.aliyun.com/ubuntu/ focal main restricted universe multiverse
#
#deb http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
#deb-src http://mirrors.aliyun.com/ubuntu/ focal-security main restricted universe multiverse
#
#deb http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
#deb-src http://mirrors.aliyun.com/ubuntu/ focal-updates main restricted universe multiverse
#
## deb http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
## deb-src http://mirrors.aliyun.com/ubuntu/ focal-proposed main restricted universe multiverse
#
#deb http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
#deb-src http://mirrors.aliyun.com/ubuntu/ focal-backports main restricted universe multiverse
#EOF
#
###########setting oh my zsh################
# install net-tools zsh
apt-get update
apt-get install -y net-tools vim zsh curl tree neofetch

#setting git config
git config --global user.name "luogeshibu"
git config --global user.email "luogeshibu@gmail.com"

# install oh-my-zsh from github and install some useful plugins.
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# setting .zshrc file default values
sed -i 's/(git)/(git zsh-autosuggestions  zsh-syntax-highlighting)/g' /root/.zshrc
sed -i 's/robbyrussell/aussiegeek/g' /root/.zshrc
echo "export EDITOR='vim'" >> /root/.zshrc
echo "export VISUAL='vim'" >> /root/.zshrc
echo "neofetch" >> /root/.zshrc
# change default shell from bash to zsh.
chsh -s $(which zsh)

#############install docker-ce and docker-compose ########################
# install latest docker-ce on ubuntu
apt-get install -y \
ca-certificates \
curl \
gnupg \
lsb-release

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

#install gh , github login software
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null
sudo apt update
sudo apt install gh

#
lvextend -L +30G /dev/ubuntu-vg/ubuntu-lv && resize2fs /dev/ubuntu-vg/ubuntu-lv
