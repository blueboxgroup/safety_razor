# -*- encoding: utf-8 -*-

require File.join(File.dirname(__FILE__), %w{.. .. spec_helper})

require 'safety_razor/client'
require 'safety_razor/slice/model'

describe SafetyRazor::Client do

  let(:client) { SafetyRazor::Client.new(:uri => "http://razor.example.com") }

  describe "#connection" do

    it "is a Faraday::Connection" do
      client.connection.must_be_instance_of Faraday::Connection
    end

    it "sets a url_prefix" do
      client.connection.url_prefix.to_s.must_equal "http://razor.example.com/"
    end
  end

  describe "#model" do

    it "creates a SafetyRazor::Slice::Model" do
      SafetyRazor::Slice::Model.expects(:new).with(client)

      client.model
    end
  end
end
