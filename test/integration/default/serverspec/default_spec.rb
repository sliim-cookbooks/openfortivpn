# -*- coding: utf-8 -*-

require 'spec_helper'

describe command 'openfortivpn --version' do
  its(:exit_status) { should eq 0 }
end

describe file '/etc/openfortivpn/config' do
  it { should be_file }
  its(:content) { should match(/^host = encrypted-host$/) }
  its(:content) { should match(/^port = 1337$/) }
  its(:content) { should match(/^username = encrypted-username$/) }
  its(:content) { should match(/^password = encrypted-password$/) }
  its(:content) { should match(/^trusted-cert = encrypted-trusted-cert/) }
end
