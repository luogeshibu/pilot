#!/bin/bash
###This shell script is for root user. you should have root permission.

#echo root:1347808093Shibu | chpasswd
#echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
#systemctl restart sshd

# setting system time zone
#sudo timedatectl set-timezone Asia/Chongqing

###########setting oh my zsh################
# install net-tools zsh
apt-get update
apt-get install -y net-tools zsh curl tree neofetch git

[ $? -ne 0 ] && echo "your apt source list is right or not? can not install stuff." && exit 1
#setting git config
#git config --global user.name "luogeshibu"
#git config --global user.email "luogeshibu@gmail.com"

#clean old configurtion.
cd ; rm -rf .oh-my-zsh/ ;  rm -rf .zshrc
# install oh-my-zsh from github and install some useful plugins.
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# setting .zshrc file default values
sed -i 's/(git)/(git zsh-autosuggestions  zsh-syntax-highlighting)/g' /root/.zshrc
sed -i 's/robbyrussell/amuse/g' /root/.zshrc
echo "export EDITOR='vim'" >> /root/.zshrc
echo "export VISUAL='vim'" >> /root/.zshrc
echo "neofetch" >> /root/.zshrc

# change default shell from bash to zsh.
chsh -s $(which zsh)
