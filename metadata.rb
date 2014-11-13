name             'teagent'
maintainer       'ThousandEyes'
maintainer_email 'opensource+chef@thousandeyes.com'
license          'GPLv3'
description      'Installs and configures the ThousandEyes Enterprise Agent'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.2'
provides         'teagent'

recipe 'teagent', 'Installs and configures the ThousandEyes Enterprise Agent'

# actually tested on
supports 'redhat'
supports 'centos'
supports 'debian'
supports 'ubuntu'
