# -*- encoding: utf-8 -*-

require 'safety_razor/slice/base'

module SafetyRazor

  module Slice

    # Client API for Razor's model slice.
    #
    # @author Fletcher Nichol <fnichol@nichol.ca>
    #
    class Model < Base

      private

      def slice_name
        "model"
      end
    end
  end
end
