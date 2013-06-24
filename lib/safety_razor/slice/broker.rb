# -*- encoding: utf-8 -*-

require 'safety_razor/slice/base'

module SafetyRazor

  module Slice

    # Client API for Razor's broker slice.
    #
    # @author Fletcher Nichol <fnichol@nichol.ca>
    #
    class Broker < Base

      def plugins
        response = connection.get(slice_path("plugins"))
        parse(response)
      end

      private

      def slice_name
        "broker"
      end
    end
  end
end
