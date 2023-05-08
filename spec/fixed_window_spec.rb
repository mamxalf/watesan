# frozen_string_literal: true

require 'redis'
require 'watesan'
require 'debug'
require 'constants'

RSpec.describe Watesan::FixedWindow do
  let(:redis_url) { 'redis://localhost:6379' }
  let(:limiter) { described_class.new(key: 'test_limiter') }

  before do
    redis = Redis.new(url: redis_url)
    redis.flushdb
  end

  context 'when the rate limit is not reached' do
    it 'returns false' do
      expect(limiter.limit_reached?).to be(false)
    end
  end

  context 'when the rate limit is reached' do
    it 'returns true' do
      Constants::DEFAULT_MAX_REQUEST.times do
        limiter.limit_reached?
      end
      expect(limiter.limit_reached?).to be(true)
    end
  end
end
