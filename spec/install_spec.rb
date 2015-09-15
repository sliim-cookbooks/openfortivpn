# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'openfortivpn::install' do
  let(:subject) do
    ChefSpec::SoloRunner.new(file_cache_path: '/var/chef/cache')
      .converge described_recipe
  end

  it 'includes recipe[apt]' do
    expect(subject).to include_recipe('apt')
  end

  it 'installs package[libssl-dev]' do
    expect(subject).to install_package('libssl-dev')
  end

  it 'includes recipe[build-essential]' do
    expect(subject).to include_recipe('build-essential')
  end

  it 'creates directory[/opt/openfortivpn]' do
    expect(subject).to create_directory('/opt/openfortivpn')
      .with(recursive: true)
  end

  it 'creates remote_file[/var/chef/cache/openfortivpn-v1.0.1.tar.gz]' do
    dest = '/var/chef/cache/openfortivpn-v1.0.1.tar.gz'
    src = 'https://github.com/adrienverge/openfortivpn/archive/v1.0.1.tar.gz'
    expect(subject).to create_remote_file(dest).with(source: src)
  end

  it 'runs execute[untar]' do
    expect(subject).to run_execute('untar')
      .with(cwd: '/opt/openfortivpn',
            command: 'tar --strip-components 1 -xzf '\
                     '/var/chef/cache/openfortivpn-v1.0.1.tar.gz')
  end

  it 'runs execute[build-openfortivpn]' do
    expect(subject).to run_execute('build-openfortivpn')
      .with(cwd: '/opt/openfortivpn',
            command: 'aclocal && autoconf && automake --add-missing &&'\
                     './configure --prefix=/usr --sysconfdir=/etc &&'\
                     'make')
  end

  it 'runs execute[make install]' do
    expect(subject).to run_execute('make install')
      .with(cwd: '/opt/openfortivpn')
  end
end
