# -*- encoding: utf-8 -*-

require File.join(File.dirname(__FILE__), %w{.. .. spec_helper})

require 'safety_razor/client'

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

  describe "#tag" do

    it "creates a SafetyRazor::Slice::Tag" do
      SafetyRazor::Slice::Tag.expects(:new).with(client)

      client.tag
    end
  end

  describe "#tag_matcher" do

    it "creates a SafetyRazor::Slice::TagMatcher" do
      SafetyRazor::Slice::TagMatcher.expects(:new).with(client)

      client.tag_matcher
    end
  end

  describe "#policy" do

    it "creates a SafetyRazor::Slice::Policy" do
      SafetyRazor::Slice::Policy.expects(:new).with(client)

      client.policy
    end
  end

  describe "#broker" do

    it "creates a SafetyRazor::Slice::Broker" do
      SafetyRazor::Slice::Broker.expects(:new).with(client)

      client.broker
    end
  end

  describe "#node" do

    it "creates a SafetyRazor::Slice::Node" do
      SafetyRazor::Slice::Node.expects(:new).with(client)

      client.node
    end
  end
end
