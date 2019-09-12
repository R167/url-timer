require 'sinatra'
require "sinatra/json"
require "http"

get '/' do
  json status: 'ok'
end

get '/timing' do
  if params['url']
    start = Time.now
    response = HTTP.get(params['url'])
    time = Time.now - start

    json {time: time, status: response.code}
  else
    json {usage: 'pass a url query param'}
  end
end
