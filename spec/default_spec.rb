# -*- coding: utf-8 -*-

require_relative 'spec_helper'

describe 'openfortivpn::default' do
  let(:subject) do
    ChefSpec::SoloRunner.new(file_cache_path: '/var/chef/cache')
      .converge described_recipe
  end

  %w(install config).each do |recipe|
    it "includes recipe[openfortivpn::#{recipe}]" do
      expect(subject).to include_recipe("openfortivpn::#{recipe}")
    end
  end
end
