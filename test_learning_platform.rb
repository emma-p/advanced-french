require_relative 'learning_platform'
require 'test/unit'
require 'rack/test'
ENV['RACK_ENV'] = 'test'

class LearningPlatformIndexTest < Test::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_it_loads_the_index
    get '/'
    assert last_response.ok?
  end
end
