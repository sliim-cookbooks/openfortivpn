# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'openfortivpn::config' do
  context 'with chef-solo' do
    let(:subject) do
      ChefSpec::SoloRunner.new do |node|
        node.set['openfortivpn']['config']['host'] = 'host-from-attr'
        node.set['openfortivpn']['config']['port'] = 1111
        node.set['openfortivpn']['config']['username'] = 'user-from-attr'
        node.set['openfortivpn']['config']['password'] = 'pass-from-attr'
        node.set['openfortivpn']['config']['trusted-cert'] = 'cert-from-attr'
      end.converge(described_recipe)
    end

    it 'creates directory[/etc/openfortivpn]' do
      expect(subject).to create_directory('/etc/openfortivpn')
    end

    it 'creates template[/etc/openfortivpn/config]' do
      expect(subject).to create_template('/etc/openfortivpn/config')
        .with(source: 'config.erb',
              variables: {
                config: {
                  'data_bag_name' => 'config',
                  'host' => 'host-from-attr',
                  'port' => 1111,
                  'username' => 'user-from-attr',
                  'password' => 'pass-from-attr',
                  'trusted-cert' => 'cert-from-attr'
                }
              }
             )
    end
  end

  context 'with data bag' do
    before do
      allow(Chef::EncryptedDataBagItem).to receive(:load_secret)
        .and_return('stub_secret')
      allow(Chef::EncryptedDataBagItem).to receive(:load)
        .with('openfortivpn', 'config', 'stub_secret')
        .and_return('id' => 'config',
                    'host' => 'host-from-db',
                    'port' => 42,
                    'username' => 'user-from-db',
                    'password' => 'pass-from-db',
                    'trusted-cert' => 'trusted-cert-from-db')
    end

    subject { ChefSpec::ServerRunner.new.converge(described_recipe) }

    it 'creates directory[/etc/openfortivpn]' do
      expect(subject).to create_directory('/etc/openfortivpn')
    end

    it 'creates template[/etc/openfortivpn/config]' do
      expect(subject).to create_template('/etc/openfortivpn/config')
        .with(source: 'config.erb',
              variables: {
                config: {
                  'id' => 'config',
                  'host' => 'host-from-db',
                  'port' => 42,
                  'username' => 'user-from-db',
                  'password' => 'pass-from-db',
                  'trusted-cert' => 'trusted-cert-from-db'
                }
              }
             )
    end
  end

  context 'without data bag' do
    let(:exception) do
      Net::HTTPServerException.new('Not found', {})
    end

    before do
      allow(Chef::EncryptedDataBagItem).to receive(:load_secret)
        .and_return('stub_secret')
      allow(Chef::EncryptedDataBagItem).to receive(:load)
        .with('openfortivpn', 'config', 'stub_secret')
        .and_raise(exception)
    end

    subject { ChefSpec::ServerRunner.new.converge(described_recipe) }

    it 'creates directory[/etc/openfortivpn]' do
      expect(subject).to create_directory('/etc/openfortivpn')
    end

    it 'creates template[/etc/openfortivpn/config]' do
      expect(subject).to create_template('/etc/openfortivpn/config')
        .with(source: 'config.erb',
              variables: {
                config: {
                  'data_bag_name' => 'config',
                  'host' => 'vpn-gateway',
                  'port' => 8443,
                  'username' => 'foo',
                  'password' => '',
                  'trusted-cert' => 'e46d4a'
                }
              }
             )
    end
  end
end
