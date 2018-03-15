#
# Cookbook Name:: teagent
# Recipe:: default
#
# Copyright 2013, ThousandEyes, Inc.
#

include_recipe 'teagent::dependency' if node['teagent']['set_repo']

package 'te-agent'

package 'te-agent-utils' if node['teagent']['agent_utils']

package 'te-browserbot' if node['teagent']['browserbot']

package 'te-intl-fonts' if node['teagent']['international_langs']

if node['teagent']['chef_template_config']
  template 'etc/te-agent.cfg' do
    source 'te-agent.cfg.erb'
    mode '0644'
    owner 'root'
    group 'root'
    variables(
      account_token: node['teagent']['config']['account_token'],
      log_file_size: node['teagent']['config']['log_file_size'],
      log_level: node['teagent']['config']['log_level'],
      log_path: node['teagent']['config']['log_path'],
      num_log_files: node['teagent']['config']['num_log_files'],
      proxy_type: node['teagent']['config']['proxy_type'],
      proxy_location: node['teagent']['config']['proxy_location'],
      proxy_user: node['teagent']['config']['proxy_user'],
      proxy_pass: node['teagent']['config']['proxy_pass'],
      proxy_bypass_list: node['teagent']['config']['proxy_bypass_list'],
      crash_reports: node['teagent']['config']['crash_reports']
    )
  end
# The config_teagent.sh has not been updated after proxy host and port were made obsolete.
else
  template '/var/lib/te-agent/config_teagent.sh' do
    source 'config_teagent.sh.erb'
    mode '0755'
    owner 'root'
    group 'root'
    variables(
      real_account_token: node['teagent']['config']['account_token'],
      real_log_path: node['teagent']['config']['log_path'],
      real_proxy_host: node['teagent']['config']['proxy_host'],
      real_proxy_port: node['teagent']['config']['proxy_port'],
      real_proxy_user: node['teagent']['config']['proxy_user'],
      real_proxy_pass: node['teagent']['config']['proxy_pass'],
      real_ip_version: node['teagent']['ip_version'],
      real_interface: node['teagent']['interface']
    )
    action :create
    notifies :run, 'execute[config_teagent.sh]', :immediately
  end
end

execute 'config_teagent.sh' do
  command '/var/lib/te-agent/config_teagent.sh'
  action :nothing
end

include_recipe 'teagent::service'
