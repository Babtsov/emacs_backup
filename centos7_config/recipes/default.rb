#
# Cookbook:: centos7_config
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

user 'vagrant'

# repo config
package 'epel-release'
execute 'install_ius' do
  command 'yum install https://centos7.iuscommunity.org/ius-release.rpm -y'
  not_if 'yum repolist | grep \'IUS Community Packages\''
end

# emacs config
cookbook_file '/tmp/emacs-25.2.rpm' do
  source 'emacs-25.2-1.el7.x86_64.rpm'
  mode '0755'
  action :create
end

yum_package '/tmp/emacs-25.2.rpm'

package 'tmux2u'
package 'git2u'
