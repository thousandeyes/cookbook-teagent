
### Cookbook Name:: teagent
### Recipe:: service
##
#
# Copyright © 2013 ThousandEyes, Inc.
#

service 'te-agent' do
    case node['platform']
        when 'redhat','centos'
            if node['platform_version'].to_f < 7.0
                provider Chef::Provider::Service::Upstart
                supports [:restart, :status]
            else
                provider Chef::Provider::Service::Systemd
                supports [:restart, :status]
            end

        when 'ubuntu'
            if node['platform_version'].to_f < 15.04
                provider Chef::Provider::Service::Upstart
                supports [:restart, :status]
            else
                provider Chef::Provider::Service::Systemd
                supports [:restart, :status]
            end
    end
    action [:start, :enable]
end
