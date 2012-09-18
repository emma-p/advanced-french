require_relative '../../learning_platform'
require 'test/unit'
require 'rack/test'
ENV['RACK_ENV'] = 'test'

class Test::Unit::TestCase
  include Rack::Test::Methods
  end

def app
  Sinatra::Application
end

class LearningPlatformIndexTest < Test::Unit::TestCase

  def test_it_loads_the_index
    get '/'
    assert last_response.ok?
  end
end

class LearningPlatformLessonsPageTest < Test::Unit::TestCase

  def test_it_loads_the_lessons_page
    get '/lessons' 
    assert last_response.ok?
  end
end

class LearningPlatformExercisesPageTest < Test::Unit::TestCase

  def test_it_loads_the_exercises_page
    get '/exercises' 
    assert last_response.ok?
    assert last_response.body.include?('Exercices')
  end
end
