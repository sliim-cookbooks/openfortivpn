# -*- coding: utf-8 -*-

require 'spec_helper'

describe command 'openfortivpn --version' do
  its(:exit_status) { should eq 0 }
end

describe file '/etc/openfortivpn/config' do
  it { should be_file }
  its(:content) { should match(/^host = vpn-gateway$/) }
  its(:content) { should match(/^port = 8443$/) }
  its(:content) { should match(/^username = foo$/) }
  its(:content) { should match(/^password = $/) }
  its(:content) { should match(/^trusted-cert = e46d4a/) }
end
