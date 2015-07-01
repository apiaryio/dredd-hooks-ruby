require 'aruba/cucumber'
require "sinatra/base"
require 'rack/test'

ENV['RACK_ENV'] = 'test'

Before do
  @aruba_timeout_seconds = 10
end

class MyWorld
  include Rack::Test::Methods
  def app
  end
end


World{MyWorld.new}