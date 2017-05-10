#
### Cookbook Name:: teagent
### Recipe:: service
##
#
# Copyright © 2013 ThousandEyes, Inc.
#

service 'te-agent' do
    case node['platform']
    when 'redhat','centos'
        provider Chef::Provider::Service::Upstart
        supports [:restart, :status]

    when 'ubuntu'
        case node['platform_version']
        when '16.04'
            provider Chef::Provider::Service::Systemd
            supports [:restart, :status]
        else
            provider Chef::Provider::Service::Upstart
            supports [:restart, :status]
        end


    when 'debian'
        pattern 'te-agent'
        supports [:restart]
    end
    #supports [:restart, :status]
    action [:start, :enable]
end
