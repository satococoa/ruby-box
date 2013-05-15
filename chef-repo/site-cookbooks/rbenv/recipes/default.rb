#
# Cookbook Name:: rbenv
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
%w(gcc make readline-devel openssl-devel zlib-devel).each do |pkg|
  package pkg do
    action :install
  end
end

git node['user']['home'] + "/.rbenv" do
  user node['user']['name']
  group node['user']['group']
  repository "git://github.com/sstephenson/rbenv.git"
  reference "master"
  action :checkout
end

bash "rbenv" do
  user node['user']['name']
  group node['user']['group'] 
  cwd node['user']['home']
  environment "HOME" => node['user']['home']

  code <<-EOC
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc
    source ~/.bashrc
  EOC

  not_if { File.open(node['user']['home'] + "/.bashrc").read.include?('rbenv init') }
end

directory node['user']['home'] + "/.rbenv/plugins/" do
  owner node['user']['name']
  group node['user']['group']
  mode '0755'
  action :create
end

git node['user']['home'] + "/.rbenv/plugins/ruby-build" do
  repository "git://github.com/sstephenson/ruby-build.git"
  reference "master"
  action :checkout
end

bash "install ruby-#{node['rbenv']['version']}" do
  user node['user']['name']
  group node['user']['group'] 
  cwd node['user']['home']
  environment "HOME" => node['user']['home']

  code <<-EOC
    source ~/.bashrc
    cd ~/.rbenv/plugins/ruby-build
    git pull
    cd ~
    rbenv install #{node['rbenv']['version']}
    rbenv global #{node['rbenv']['version']}
    rbenv versions
    rbenv rehash
  EOC

  not_if "rbenv versions | grep #{node['rbenv']['version']}"
end
