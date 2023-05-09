# frozen_string_literal: true

require 'redis'
require 'constants'

class Watesan::FixedWindow
  def initialize(key:, options: Constants::DEFAULT_TORQUE_OPTIONS, redis_options: Constants::DEFAULT_REDIS_OPTIONS)
    @key = key
    torque_options = Constants::DEFAULT_TORQUE_OPTIONS.dup
    @options = torque_options.merge!(options)
    @redis = Redis.new(redis_options)
  end

  # TODO: return with message
  def call
    requests = @redis.get(@key).to_i
    if requests >= @options[:max_requests]
      true
    else
      @redis.multi do |multi|
        multi.incr(@key)
        multi.expire(@key, @options[:window_size])
      end
      false
    end
  end

  def limit_reached?
    call
  end
end
