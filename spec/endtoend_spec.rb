require_relative '../learning_platform'
require_relative 'spec_helper'

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe 'home page' do
  it 'loads the index' do
    get '/'
    last_response.should be_ok
  end
end

describe 'lessons page' do
  it 'displays the lessons as specified in the JSON file' do
    lesson_categories = Lesson.parse_lesson_file
    get '/lessons'
    last_response.should be_ok

    lesson_categories.each do |lesson_info|
      last_response.body.should include lesson_info["title"]
    end
  end
end
# class LearningPlatformIndexTest < Test::Unit::TestCase
# 
#   def test_it_loads_the_index
#     get '/'
#     assert last_response.ok?
#   end
# end
# 
# class LearningPlatformLessonsPageTest < Test::Unit::TestCase
# 
#   def test_it_loads_the_lessons_page
#     get '/lessons' 
#     assert last_response.ok?
#   end
# end
# 
# class LearningPlatformExercisesPageTest < Test::Unit::TestCase
# 
#   def test_it_loads_the_exercises_page
#     get '/exercises' 
#     assert last_response.ok?
#     assert last_response.body.include?('Exercices')
#   end
# end
