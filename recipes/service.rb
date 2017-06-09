
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
                #subscribes :restart, 'template[te-agent-upstart-service]', :immediately
            else
                provider Chef::Provider::Service::Systemd
                supports [:restart, :status]
                #subscribes :restart, 'template[te-agent-systemd-service]', :immediately
            end

        when 'ubuntu'
            if node['platform_version'] == '16.04'
                provider Chef::Provider::Service::Systemd
                supports [:restart, :status]
            else
                provider Chef::Provider::Service::Upstart
                supports [:restart, :status]
            end
    end
    action [:start, :enable]
end
