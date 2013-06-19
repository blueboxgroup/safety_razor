# -*- encoding: utf-8 -*-

require "faraday"
require "json"
require "hashie"

require "safety_razor/slice/model"
require "safety_razor/slice/tag"

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
  end
end
