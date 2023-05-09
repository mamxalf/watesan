# frozen_string_literal: true

class Constants
  # set default window size and max request for limiting
  DEFAULT_WINDOW_SIZE = 60
  DEFAULT_MAX_REQUEST = 100
  public_constant :DEFAULT_WINDOW_SIZE
  public_constant :DEFAULT_MAX_REQUEST

  # Default Redis host: localhost
  DEFAULT_REDIS_HOST = 'localhost'
  public_constant :DEFAULT_REDIS_HOST

  # Default Redis post: 6379
  DEFAULT_REDIS_PORT = 6379
  public_constant :DEFAULT_REDIS_PORT

  # Default Redis options when creating a connection to Redis
  DEFAULT_REDIS_OPTIONS = {
    host: DEFAULT_REDIS_HOST,
    port: DEFAULT_REDIS_PORT
  }.freeze
  public_constant :DEFAULT_REDIS_OPTIONS

  DEFAULT_TORQUE_OPTIONS = {
    window_size:  Constants::DEFAULT_WINDOW_SIZE,
    max_requests: Constants::DEFAULT_MAX_REQUEST
  }.freeze
  public_constant :DEFAULT_TORQUE_OPTIONS
end
