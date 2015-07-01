require 'aruba/cucumber'
require "sinatra/base"

Before do
  @aruba_timeout_seconds = 10
end