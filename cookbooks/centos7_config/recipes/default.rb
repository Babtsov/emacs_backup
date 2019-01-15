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
cache_dir = "#{Chef::Config[:file_cache_path]}"
cookbook_file "#{cache_dir}/emacs-25.2.rpm" do
  source 'emacs-25.2-1.el7.x86_64.rpm'
  mode '0755'
  action :create
end

yum_package "#{cache_dir}/emacs-25.2.rpm"
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

link '/bin/emacs' do
  to '/usr/local/bin/emacs'
end


# tmux config
package 'tmux2u'
cookbook_file "#{home}/.tmux.conf" do
  source '.tmux.conf'
  owner "#{usr}"
  action :create
end


package 'git2u'

package 'the_silver_searcher'
