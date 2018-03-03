#
## Cookbook Name:: teagent
## Recipe:: dependency
#
# Copyright © 2013 ThousandEyes, Inc.
#

case node['platform']

when 'ubuntu'
    case node['platform_version']
    when '14.04' , '16.04'
        package 'lsb-release' do
            action :install
        end
        include_recipe 'teagent::repository'
    else
        Chef::Application.fatal!('Only Ubuntu 14.04(trusty) and 16.04 (xenial) are supported. Please contact support.')
    end
when 'rhel','redhat','centos'
    if node['platform_version'].to_f >= 6.3
        include_recipe 'teagent::repository'
    else
        Chef::Application.fatal!("Please upgrade your operating system (#{node['platform']}) to >= 6.3")
    end
else
    Chef::Application.fatal!("#{node['platform']} isn't supported.")
end
