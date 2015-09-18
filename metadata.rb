# -*- coding: utf-8 -*-
name 'openfortivpn'
maintainer 'Sliim'
maintainer_email 'sliim@mailoo.org'
license 'Apache 2.0'
description 'Installs/Configures openfortivpn'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

recipe 'default', 'Includes all recipes.'
recipe 'install', 'Downloads, builds and installs openfortivpn from source.'
recipe 'config', 'Configures openfortivpn from attributes or data bags.'

depends 'apt'
depends 'build-essential'

supports 'debian', '>= 7.0'
supports 'ubuntu', '= 14.04'
