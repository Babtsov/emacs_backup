#!/bin/bash
# script to automate the installation on centos 7

REPO_NAME=emacs_backup

# configure emacs
sudo yum install ~/"$REPO_NAME"/rpms/emacs-25.2-1.el7.x86_64.rpm -y
cp -r ~/"$REPO_NAME"/cli_emacs/.emacs.d/ ~
cp  ~/"$REPO_NAME"/cli_emacs/.emacs ~

# configure bash
cp ~/"$REPO_NAME"/default_install/.bash_profile  ~/.bash_profile

# install IUS repo (https://support.rackspace.com/how-to/install-epel-and-additional-repositories-on-centos-and-red-hat/)
sudo yum install -y https://$(rpm -E '%{?centos:centos}%{!?centos:rhel}%{rhel}').iuscommunity.org/ius-release.rpm
sudo yum install yum-plugin-replace -y

# configure tmux
sudo yum install tmux2u -y
cp ~/"$REPO_NAME"/default_install/.tmux.conf ~

# configure git
sudo yum replace git --replace-with git2u -y
git config --global user.name "Ben Babtsov"
git config --global user.email "ben.babtsov@ufl.edu"
