# -*- coding: utf-8 -*-
require 'chefspec'
require 'chefspec/berkshelf'

ChefSpec::Coverage.start! { add_filter 'openfortivpn' }

require 'chef/application'
