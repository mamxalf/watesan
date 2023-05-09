# frozen_string_literal: true

require 'watesan/abstract'

class Watesan::FixedWindow < Watesan::Abstract
  def initialize(key:, options: Constants::DEFAULT_TORQUE_OPTIONS, redis_options: Constants::DEFAULT_REDIS_OPTIONS)
    init(redis_options, options)
    @key = key
  end

  # TODO: return with message, and handling error
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
