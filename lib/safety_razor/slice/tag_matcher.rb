# -*- encoding: utf-8 -*-

require 'safety_razor/slice/base'

module SafetyRazor

  module Slice

    # Client API for Razor's tag matcher slice.
    #
    # @author Fletcher Nichol <fnichol@nichol.ca>
    #
    class TagMatcher < Base

      def create(tag_uuid, params)
        payload = JSON.generate(params)
        response = connection.post(slice_path(tag_uuid), 'json_hash' => payload)
        parse(response).first
      end

      def get(tag_uuid, uuid)
        response = connection.get(slice_path(tag_uuid, uuid))
        parse(response).first
      end

      def all
        raise NoMethodError, "TagMatcher#all is not defined"
      end

      def update(tag_uuid, params)
        payload = JSON.generate(params)
        uuid = params[:uuid]
        response = connection.put(slice_path(tag_uuid, uuid),
          'json_hash' => payload)
        parse(response).first
      end

      def destroy(tag_uuid, uuid)
        connection.delete(slice_path(tag_uuid, uuid))
      end

      protected

      def slice_path(tag_uuid, uuid = nil)
        path = "/razor/api/tag/#{tag_uuid}/matcher"
        path += "/#{uuid}" if uuid
        path
      end

      def new_mash(obj)
        Hashie::Mash.new(obj).extend(KeyReaderMethod)
      end

      # Overrides a Hash method collision with the tag matcher attribute of
      # `key'.
      #
      module KeyReaderMethod

        def key
          self["key"]
        end
      end
    end
  end
end
