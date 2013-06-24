# -*- encoding: utf-8 -*-

require 'minitest/autorun'
require 'mocha/setup'

require 'safety_razor'

describe "Broker Slice" do

  let(:client) { SafetyRazor::Client.new(:uri => 'http://127.0.0.1:8026') }

  before do
    %x{vagrant ssh --command 'sudo razor broker remove all'}
  end

  it "manages a broker" do
    client.broker.plugins.find { |t| t.plugin == "puppet" }.
      description.must_equal "PuppetLabs PuppetMaster"

    client.broker.all.must_equal []

    broker = client.broker.create({
      :name => "Chefy",
      :plugin => "chef",
      :description => "Production Chef Server",
      :req_metadata_hash => {
        :chef_server_url => "https://chef.example.com",
        :chef_version => "11.4.0",
        :validation_key => "-----BEGIN RSA PRIVATE KEY-----\nMIIEogIBAAK..."
      }
    })
    broker.name.must_equal "Chefy"
    broker.chef_version.must_equal "11.4.0"

    all = client.broker.all
    all.size.must_equal 1
    all.first.uuid.must_equal broker.uuid

    fetched_broker = client.broker.get(broker.uuid)
    fetched_broker.uuid.must_equal broker.uuid
    fetched_broker.name.must_equal "Chefy"

    updated_broker = client.broker.update({
      :uuid => broker.uuid,
      :name => "Updated Chefy"
    })
    updated_broker.name.must_equal "Updated Chefy"

    client.broker.destroy(broker.uuid)
    client.broker.all.must_equal []
  end
end
