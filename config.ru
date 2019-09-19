# frozen_string_literal: true
require './app/start'

configure do
  set :protection, :except => [:json_csrf]
end

run Sinatra::Application
