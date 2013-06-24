# -*- encoding: utf-8 -*-

require 'safety_razor/slice/base'

module SafetyRazor

  module Slice

    # Client API for Razor's active model slice.
    #
    # @author Fletcher Nichol <fnichol@nichol.ca>
    #
    class ActiveModel < Base

      def create(params)
        raise NoMethodError, "Node#create is not defined"
      end

      def update(params)
        raise NoMethodError, "Node#update is not defined"
      end

      private

      def slice_name
        "active_model"
      end
    end
  end
end
