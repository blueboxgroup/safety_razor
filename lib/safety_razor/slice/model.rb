# -*- encoding: utf-8 -*-

module SafetyRazor

  module Slice

    # Client API for Razor's model slice.
    #
    # @author Fletcher Nichol <fnichol@nichol.ca>
    #
    class Model

      def initialize(client)
        @client = client
      end

      def create(params)
        payload = JSON.generate(params)
        response = connection.post(slice_path, 'json_hash' => payload)
        parse(response).first
      end

      def get(uuid)
        response = connection.get(slice_path(uuid))
        parse(response).first
      end

      def all
        response = connection.get(slice_path)
        parse(response)
      end

      def update(params)
        payload = JSON.generate(params)
        uuid = params[:uuid]
        response = connection.put(slice_path(uuid), 'json_hash' => payload)
        parse(response).first
      end

      def destroy(uuid)
        connection.delete(slice_path(uuid))
      end

      private

      attr_reader :client

      def connection
        client.connection
      end

      def slice_name
        "model"
      end

      def slice_path(uuid = nil)
        path = "/razor/api/#{slice_name}"
        path += "/#{uuid}" if uuid
        path
      end

      def parse(response)
        Array(JSON.parse(response.body)["response"]).map do |obj|
          Hashie::Mash.new(strip_ivars(obj))
        end
      end

      def strip_ivars(obj)
        case obj
        when Hash
          stripped = Hash.new
          obj.each_pair do |key, value|
            new_key = key.is_a?(String) ? key.sub(/^@/, '') : key
            stripped[new_key] = strip_ivars(value)
          end
          stripped
        when Array
          obj.map { |value| strip_ivars(value) }
        else
          obj
        end
      end
    end
  end
end
