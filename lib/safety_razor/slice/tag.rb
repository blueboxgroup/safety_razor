# -*- encoding: utf-8 -*-

require 'safety_razor/slice/base'

module SafetyRazor

  module Slice

    # Client API for Razor's tag slice.
    #
    # @author Fletcher Nichol <fnichol@nichol.ca>
    #
    class Tag < Base

      private

      def slice_name
        "tag"
      end
    end
  end
end
