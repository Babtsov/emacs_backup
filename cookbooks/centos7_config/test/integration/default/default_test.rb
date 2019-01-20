# # encoding: utf-8

# Inspec test for recipe centos7_config::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe bash('emacs --version | grep \'Emacs 25\'') do
  its('exit_status') { should eq 0 }
end

describe bash('tmux -V | grep \'tmux 2\'') do
  its('exit_status') { should eq 0 }
end

describe bash('ag --version') do
  its('exit_status') { should eq 0 }
end

describe bash('python3 --version | grep 3.6') do
  its('exit_status') { should eq 0 }
end

describe bash('pip3 --version') do
  its('exit_status') { should eq 0 }
end
