#
# Cookbook Name:: teagent
# Recipe:: default
#
# Copyright 2013, ThousandEyes, Inc.
#

include_recipe 'teagent::dependency'

package 'te-agent' do
    action :install
end

if node['teagent']['browserbot']
    package 'te-browserbot' do
        action :install
    end
end

if node['teagent']['international_langs']
    package 'te-intl-fonts' do
        action :install
    end
end

template '/var/lib/te-agent/config_teagent.sh' do
    source 'config_teagent.sh.erb'
    mode '0755'
    owner 'root'
    group 'root'
    variables({
        :real_account_token => node['teagent']['account_token'],
        :real_log_path => node['teagent']['log_path'],
        :real_proxy_host => node['teagent']['proxy_host'],
        :real_proxy_port => node['teagent']['proxy_port'],
        :real_ip_version => node['teagent']['ip_version'],
    })
    action :create_if_missing
    notifies :run, "execute[config_teagent.sh]", :immediately
end

execute 'config_teagent.sh' do
    command '/var/lib/te-agent/config_teagent.sh'
    action :nothing
end

include_recipe 'teagent::service'
