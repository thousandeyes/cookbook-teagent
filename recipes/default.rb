#
# Cookbook Name:: teagent
# Recipe:: default
#
# Copyright 2013, ThousandEyes, Inc.
#

include_recipe 'teagent::dependency' if node['teagent']['set_repo']

package 'te-agent' do
    version node['teagent']['version'] unless node['teagent']['is_canary'] 
end

package 'te-agent-utils' if node['teagent']['agent_utils']

package 'te-browserbot' if node['teagent']['browserbot']

package 'te-intl-fonts' if node['teagent']['international_langs']

template 'etc/te-agent.cfg' do
  source 'te-agent.cfg.erb'
  mode '0644'
  owner 'root'
  group 'root'
end

include_recipe 'teagent::service'
