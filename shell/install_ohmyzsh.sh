#!/bin/bash
###This shell script is for root user. you should have root permission.
if [ `id -u` != "0" ]; then
    echo "Sorry, you are not root."
    exit 1
fi

# check your system...
if [ $(command -v apt-get) ]
then
  # install net-tools zsh
  apt-get update
  apt-get install -y net-tools zsh curl tree git
elif [ $(command -v yum) ]
then
  # install net-tools zsh
  yum -y update
  yum -y install net-tools zsh curl tree git
else
  echo -e " 
  This shell script is not working on your system. (-_-) 

  only support: Ubuntu 16+ / Debian 8+ / CentOS 7+ 
  " && exit 2
fi

#apt-get -v &> /dev/null && apt-get update || yum update
#echo root:1347808093Shibu | chpasswd
#echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
#systemctl restart sshd

# setting system time zone
#sudo timedatectl set-timezone Asia/Chongqing

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
sed -i 's/robbyrussell/amuse/g' ./.zshrc
echo "export EDITOR='vim'" >> ./.zshrc
echo "export VISUAL='vim'" >> ./.zshrc
#echo "neofetch" >> ./.zshrc

# change default shell from bash to zsh.
# chsh -s $(which zsh)  #Warning: manual execute this command.
