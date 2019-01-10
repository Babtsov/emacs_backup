#
# Cookbook:: centos7_config
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
usr = 'vagrant'
user "#{usr}"
home = node['etc']['passwd'][usr]['dir']

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
cookbook_file "#{home}/.emacs" do
  source '.emacs'
  owner "#{usr}"
  action :create
end

remote_directory  "#{home}/.emacs.d" do
  source '.emacs.d'
  owner "#{usr}"
  action :create
end



package 'tmux2u'
cookbook_file "#{home}/.tmux.conf" do
  source '.tmux.conf'
  owner "#{usr}"
  action :create
end




package 'git2u'

package 'the_silver_searcher'
