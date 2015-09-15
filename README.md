# openfortivpn Cookbook | [![Cookbook Version](https://img.shields.io/cookbook/v/openfortivpn.svg)](https://community.opscode.com/cookbooks/openfortivpn) [![Build Status](https://travis-ci.org/sliim-cookbooks/openfortivpn.svg?branch=master)](https://travis-ci.org/sliim-cookbooks/openfortivpn) 

Builds, installs, and configures [openfortivpn](https://github.com/adrienverge/openfortivpn).

## Requirements

#### Platforms
- Debian 7
- Debian 8
- Ubuntu 14.04

#### Cookbooks
- `apt` - https://supermarket.chef.io/cookbooks/apt
- `build-essential` - https://supermarket.chef.io/cookbooks/build-essential

## Usage
#### openfortivpn::default
Includes both recipes: `openfortivpn::install` and `openfortivpn::config`.

#### openfortivpn::install
Download, build and install openfortivpn from source.

#### openfortivpn::config
Setup `/etc/openfortivpn/config` configuration file.

Configuration can be specified with attributes (see below) or data bags.
Recommended way is to create a data bag named `openfortivpn` and create an encrypted data bag object `config`:
```
{
    "id": "config",
    "host": "SERVER_HOST",
    "port": "SERVER_PORT",
    "username": "YOUR_USERNAME",
    "password": "YOUR_PASSWORD",
    "trusted-cert": "YOUR_CERT"
}
```

The ID of this data bag object can be changed with `node[openfortivpn][config][data_bag_name]`

## Attributes

#### openfortivpn::install
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['openfortivpn']['install']['version']</tt></td>
    <td>String</td>
    <td>Version to install</td>
    <td><tt>v1.0.1</tt></td>
  </tr>
  <tr>
    <td><tt>['openfortivpn']['install']['build_dir']</tt></td>
    <td>String</td>
    <td>Path to build directory</td>
    <td><tt>/opt/openfortivpn</tt></td>
  </tr>
</table>

#### openfortivpn::config
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['openfortivpn']['config']['data_bag_name']</tt></td>
    <td>String</td>
    <td>Use this data bag instead of attributes</td>
    <td><tt>config</tt></td>
  </tr>
  <tr>
    <td><tt>['openfortivpn']['config']['host']</tt></td>
    <td>String</td>
    <td>Host of the VPN gateway</td>
    <td><tt>vpn-gateway</tt></td>
  </tr>
  <tr>
    <td><tt>['openfortivpn']['config']['port']</tt></td>
    <td>Integer</td>
    <td>Port where VPN is reachable</td>
    <td><tt>8443</tt></td>
  </tr>
  <tr>
    <td><tt>['openfortivpn']['config']['username']</tt></td>
    <td>String</td>
    <td>Username for authentication</td>
    <td><tt>foo</tt></td>
  </tr>
  <tr>
    <td><tt>['openfortivpn']['config']['password']</tt></td>
    <td>String</td>
    <td>Password for authentication</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>['openfortivpn']['config']['trusted-cert']</tt></td>
    <td>String</td>
    <td>Trusted certificate</td>
    <td><tt>e46d4aff08ba6914e64daa85bc6112a422fa7ce16631bff0b592a28556f993db</tt></td>
  </tr>
</table>

## Contributing

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

## License and Authors

Authors: Sliim <sliim@mailoo.org>

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
