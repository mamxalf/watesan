# frozen_string_literal: true

require 'redis'
require 'constants'

class Watesan::FixedWindow
  DEFAULT_OPTIONS = {
    window_size:  Constants::DEFAULT_WINDOW_SIZE,
    max_requests: Constants::DEFAULT_MAX_REQUEST
  }.freeze

  private_constant :DEFAULT_OPTIONS

  def initialize(key: nil, options: DEFAULT_OPTIONS, redis_options: Constants::DEFAULT_REDIS_OPTIONS)
    @key = key
    fix_options = DEFAULT_OPTIONS.dup
    @options = fix_options.merge!(options)
    @redis = Redis.new(redis_options)
  end

  def call
    requests = @redis.get(@key).to_i
    if requests >= @options[:window_size]
      true
    else
      @redis.multi do |multi|
        multi.incr(@key)
        multi.expire(@key, @options[:max_requests])
      end
      false
    end
  end

  def limit_reached?
    call
  end
end
