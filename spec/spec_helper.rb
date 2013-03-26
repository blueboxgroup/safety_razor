# -*- encoding: utf-8 -*-

require 'simplecov'
SimpleCov.adapters.define 'gem' do
  command_name 'Specs'

  add_filter '.gem/'
  add_filter '/spec/'
  add_filter '/lib/vendor/'

  add_group 'Libraries', '/lib/'
end
SimpleCov.start 'gem'

require 'minitest/autorun'
require 'mocha/setup'
