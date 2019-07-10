# coding: utf-8
# Cookbook Name:: cookbook-teagent
# Attributes:: teagent
#
# Copyright © 2013 ThousandEyes, Inc.
#

default['teagent']['version'] = '1.66.1-1~xenial'
default['teagent']['is_canary'] = false

default['teagent']['browserbot'] = false
default['teagent']['international_langs'] = false
default['teagent']['ip_version'] = 'ipv4'
default['teagent']['interface'] = ''
default['teagent']['agent_utils'] = false
default['teagent']['set_repo'] = true

# Configuration settings
default['teagent']['config']['account_token'] = '<account-token>'
default['teagent']['config']['log_file_size'] = 10
default['teagent']['config']['log_level'] = 'DEBUG'
default['teagent']['config']['log_path'] = '/var/log'
default['teagent']['config']['num_log_files'] = 13
default['teagent']['config']['proxy_type'] = 'DIRECT'
default['teagent']['config']['proxy_location'] = ''
default['teagent']['config']['proxy_user'] = ''
default['teagent']['config']['proxy_pass'] = ''
default['teagent']['config']['crash_reports'] = 1
