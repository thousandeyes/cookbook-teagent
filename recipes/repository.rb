#
## Cookbook Name:: teagent
## Recipe:: repository
#
# Copyright © 2013 ThousandEyes, Inc.
#

case node['platform_family']

when 'rhel','fedora'
    if platform?('rhel','redhat')
        repo_os = 'RHEL'
    elsif platform?('centos')
        repo_os = 'CentOS'
    else
        Chef::Application.fatal!("#{node['platform']} isn't supported.")
    end

    repo_path = "/etc/yum.repos.d/thousandeyes.repo"
    repo_source = "thousandeyes.repo.erb"
    repo_arch = ''
    if node['kernel']['machine'] == 'i686'
        repo_arch = 'i386'
    else
        repo_arch = node['kernel']['machine']
    end
    repo_variables = { :repo_os => repo_os,
                       :architecture => repo_arch,
    }
    pub_key = "RPM-GPG-KEY-thousandeyes"
    pub_key_path = "/etc/pki/rpm-gpg"
    key_add_import = "add-rpm-key"
    key_add_import_cmd = "rpm --import #{pub_key_path}/#{pub_key}"
    repo_postinst_cmd = "yum clean all"
else
    Chef::Log.warn("#{node['platform']} isn't supported.")
end

template "#{repo_path}" do
    source "#{repo_source}"
    mode '0644'
    owner 'root'
    group 'root'
    action :create_if_missing
    variables(repo_variables)
end

cookbook_file "#{pub_key}" do
    path "#{pub_key_path}/#{pub_key}"
    mode '0644'
    owner 'root'
    group 'root'
    action :create_if_missing
    notifies :run, "execute[#{key_add_import}]", :immediately
end

execute "#{key_add_import}" do
    command "#{key_add_import_cmd}"
    action :nothing
    notifies :run, "execute[repo-postinst]", :immediately
end

execute 'repo-postinst' do
    command "#{repo_postinst_cmd}"
    action :nothing
end
