# frozen_string_literal: true

require 'constants'
require 'redis'

class Watesan::Abstract
  def init(redis_opt = Constants::DEFAULT_REDIS_OPTIONS, options = Constants::DEFAULT_TORQUE_OPTIONS)
    @redis = Redis.new(redis_opt)

    torque_options = Constants::DEFAULT_TORQUE_OPTIONS.dup
    @options = torque_options.merge!(options)
  end
end
