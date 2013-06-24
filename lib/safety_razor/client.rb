# -*- encoding: utf-8 -*-

require 'faraday'

require 'safety_razor/slice/model'
require 'safety_razor/slice/tag'
require 'safety_razor/slice/tag_matcher'
require 'safety_razor/slice/policy'
require 'safety_razor/slice/broker'
require 'safety_razor/slice/node'

module SafetyRazor

  # Client object which manages the connection to the Razor API endpoint.
  #
  # @author Fletcher Nichol <fnichol@nichol.ca>
  #
  class Client

    attr_reader :connection

    def initialize(options = {})
      @connection = Faraday.new(:url => options[:uri]) do |faraday|
        faraday.request :url_encoded
        faraday.adapter  Faraday.default_adapter
      end
    end

    def model
      @model ||= Slice::Model.new(self)
    end

    def tag
      @tag ||= Slice::Tag.new(self)
    end

    def tag_matcher
      @tag_matcher ||= Slice::TagMatcher.new(self)
    end

    def policy
      @policy ||= Slice::Policy.new(self)
    end

    def broker
      @broker ||= Slice::Broker.new(self)
    end

    def node
      @node ||= Slice::Node.new(self)
    end
  end
end
