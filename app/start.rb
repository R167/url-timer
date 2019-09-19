# frozen_string_literal: true
require 'sinatra'
require 'sinatra/json'

# only enable throttling if we have a redis_url
if ENV.include?("REDIS_URL")
  require 'rack/throttle'
  require 'redis'

  use Rack::Throttle::Minute, cache: Redis.new, key_prefix: :throttle, max: 30
end

get '/' do
  json status: 'ok'
end

get '/timing' do
  if params['url']
    begin
      start = Time.now
      response = HTTP.get(params['url'])
      time = Time.now - start

      json time: time, status: response.code, size: response.to_s.length
    rescue
      json error: "could not process url", url: params['url']
    end
  else
    json usage: 'pass a url query param'
  end
end
