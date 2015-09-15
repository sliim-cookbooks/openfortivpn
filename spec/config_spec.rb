# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'openfortivpn::config' do
  subject { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'creates directory[/etc/openfortivpn]' do
    expect(subject).to create_directory('/etc/openfortivpn')
  end

  it 'creates template[/etc/openfortivpn/config]' do
    expect(subject).to create_template('/etc/openfortivpn/config')
      .with(source: 'config.erb')
  end
end
