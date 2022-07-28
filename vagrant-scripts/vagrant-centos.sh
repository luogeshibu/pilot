#!/bin/bash

########setting system information###############
# this shell is excute by root user.
# change vagrant user password
echo vagrant:123456 | chpasswd
echo root:123456 | chpasswd

# setting permit root login yes
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/g' /etc/ssh/sshd_config
systemctl restart sshd

#install some tools
yum update
yum -y install wget net-tools vim curl zsh 

###########setting oh my zsh################

[ $? -ne 0 ] && echo "your linux repo setting is right or not? can not install stuff." && exit 3
#setting git config
#git config --global user.name "luogeshibu"
#git config --global user.email "luogeshibu@gmail.com"

###########################only use this other user#############################################3
#clean old configurtion.
cd ; rm -rf .oh-my-zsh/ ;  rm -rf ./.zshrc
# install oh-my-zsh from github and install some useful plugins.
yes | sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# setting .zshrc file default values
sed -i 's/(git)/(git zsh-autosuggestions  zsh-syntax-highlighting)/g' ./.zshrc
sed -i 's/robbyrussell/aussiegeek/g' ./.zshrc
echo "export EDITOR='vim'" >> ./.zshrc
echo "export VISUAL='vim'" >> ./.zshrc
#echo "neofetch" >> ./.zshrc

# change default shell from bash to zsh.
#chsh -s $(which zsh) #Warning: manual execute this command.
