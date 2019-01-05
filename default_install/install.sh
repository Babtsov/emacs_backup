#!/bin/bash
REPO_NAME=emacs_backup


sudo yum install -y ~/"$REPO_NAME"/rpms/{emacs-25.2-1.el7.x86_64.rpm,tmux2u-2.8-1.ius.centos7.x86_64.rpm}
cp -r ~/"$REPO_NAME"/cli_emacs/.emacs.d/ ~
cp  ~/"$REPO_NAME"/cli_emacs/.emacs ~

cp ~/"$REPO_NAME"/default_install/.tmux.conf
