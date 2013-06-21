# -*- encoding: utf-8 -*-

require 'safety_razor/slice/base'

module SafetyRazor

  module Slice

    # Client API for Razor's policy slice.
    #
    # @author Fletcher Nichol <fnichol@nichol.ca>
    #
    class Policy < Base

      def templates
        response = connection.get(slice_path("templates"))
        parse(response)
      end

      private

      def slice_name
        "policy"
      end
    end
  end
end
