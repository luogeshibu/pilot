#!/bin/bash
#ubuntu 20.04

export USER_NAME="luogeshibu"
export USER_PASS="123456"
sudo useradd --create-home -s /bin/bash ${USER_NAME}
echo "${USER_NAME}:${USER_PASS}"|sudo chpasswd
echo "${USER_NAME} ALL = (root) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/${USER_NAME}
sudo chmod 0440 /etc/sudoers.d/${USER_NAME}
