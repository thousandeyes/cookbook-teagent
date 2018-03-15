#
## Cookbook Name:: teagent
## Recipe:: repository
#
# Copyright © 2013 ThousandEyes, Inc.
#

case node['platform_family']

when 'debian'
  repo_path = '/etc/apt/sources.list.d/thousandeyes.list'
  repo_source = 'thousandeyes.list.erb'
  repo_variables = { lsbdistcodename: node['lsb']['codename'] }
  pub_key = 'thousandeyes-apt-key.pub'
  pub_key_path = '/etc/apt/trusted.gpg.d'
  key_add_import = 'add-apt-key'
  key_add_import_cmd = "apt-key add #{pub_key_path}/#{pub_key}"
  repo_postinst_cmd = 'apt-get update'

when 'rhel', 'fedora'
  if platform?('rhel', 'redhat')
    repo_os = 'RHEL'
  elsif platform?('centos')
    repo_os = 'CentOS'
  else
    Chef::Application.fatal!("#{node['platform']} isn't supported.")
  end
  platform_version = if node['platform_version'].to_f < 7
                       '6'
                     else
                       '7'
                     end

  repo_path = '/etc/yum.repos.d/thousandeyes.repo'
  repo_source = 'thousandeyes.repo.erb'
  repo_arch = if node['kernel']['machine'] == 'i686'
                'i386'
              else
                node['kernel']['machine']
              end

  repo_variables = { repo_os: repo_os,
                     architecture: repo_arch,
                     platform_version: platform_version,
  }
  pub_key = 'RPM-GPG-KEY-thousandeyes'
  pub_key_path = '/etc/pki/rpm-gpg'
  key_add_import = 'add-rpm-key'
  key_add_import_cmd = "rpm --import #{pub_key_path}/#{pub_key}"
  repo_postinst_cmd = 'yum clean all'
else
  Chef::Log.warn("#{node['platform']} isn't supported.")
end

template repo_path do
  source repo_source
  mode '0644'
  owner 'root'
  group 'root'
  action :create
  variables(repo_variables)
end

cookbook_file pub_key do
  path "#{pub_key_path}/#{pub_key}"
  mode '0644'
  owner 'root'
  group 'root'
  action :create
  notifies :run, "execute[#{key_add_import}]", :immediately
end

execute key_add_import do
  command key_add_import_cmd
  action :nothing
  notifies :run, 'execute[repo-postinst]', :immediately
end

execute 'repo-postinst' do
  command repo_postinst_cmd
  action :nothing
end
