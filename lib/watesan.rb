# frozen_string_literal: true

require_relative 'watesan/version'

require 'watesan/fixed_window'
require 'watesan/ping'
require 'watesan/sliding_window'

module Watesan
  class Error < StandardError; end
end
