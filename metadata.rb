name             'teagent'
maintainer       'ThousandEyes'
maintainer_email 'opensource+chef@thousandeyes.com'
license          'GPLv3'
description      'Installs and configures the ThousandEyes Enterprise Agent'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.2'
provides         'teagent'
chef_version     '>= 12' if respond_to?(:chef_version)

recipe 'teagent', 'Installs and configures the ThousandEyes Enterprise Agent'
issues_url 'https://github.com/thousandeyes/cookbook-teagent/issues'
source_url 'https://github.com/thousandeyes/cookbook-teagent'

# actually tested on
supports 'redhat'
supports 'centos'
supports 'debian'
supports 'ubuntu'
