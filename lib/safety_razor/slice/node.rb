# -*- encoding: utf-8 -*-

require 'safety_razor/slice/base'

module SafetyRazor

  module Slice

    # Client API for Razor's node slice.
    #
    # @author Fletcher Nichol <fnichol@nichol.ca>
    #
    class Node < Base

      def register(params)
        payload = JSON.generate(params)
        response = connection.post(slice_path("register"),
          'json_hash' => payload)
        parse(response).first
      end

      def checkin(params)
        payload = JSON.generate(params)
        response = connection.post(slice_path("checkin"),
          'json_hash' => payload)
        parse(response).first
      end

      def get_attributes(uuid)
        response = connection.get(slice_path(uuid), "field" => "attributes")
        parse(response).first
      end

      def get_hardware_ids(uuid)
        response = connection.get(slice_path(uuid), "field" => "hardware_ids")
        parse(response).first["hw_id"]
      end

      def create(params)
        raise NoMethodError, "Node#create is not defined"
      end

      def update(params)
        raise NoMethodError, "Node#update is not defined"
      end

      def destroy(uuid)
        raise NoMethodError, "Node#destroy is not defined"
      end

      private

      def slice_name
        "node"
      end
    end
  end
end
