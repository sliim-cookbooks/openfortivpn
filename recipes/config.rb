# -*- coding: utf-8 -*-
#
# Cookbook Name:: openfortivpn
# Recipe:: config
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

config = node['openfortivpn']['config']

if Chef::Config[:solo]
  Chef::Log.warn('This recipe uses search. Chef Solo does not support search. '\
                 'openfortivpn will be configured with attributes '\
                 '(not recommended)!')
else
  ssl_secret = Chef::EncryptedDataBagItem.load_secret(
    Chef::Config['encrypted_data_bag_secret'])
  begin
    config = Chef::EncryptedDataBagItem.load('openfortivpn',
                                             config['data_bag_name'],
                                             ssl_secret)
  rescue Net::HTTPServerException
    Chef::Log.warn("No data bag `#{config['data_bag_name']}` "\
                   'found for openfortivpn configuration.')
  end
end

directory '/etc/openfortivpn'
template '/etc/openfortivpn/config' do
  source 'config.erb'
  variables config: config
end
