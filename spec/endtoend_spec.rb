require_relative '../learning_platform'
require_relative 'spec_helper'
require_relative '../lesson.rb'

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
  let(:lessons_list) { Lesson.parse_lesson_file }

  before do 
    get '/lessons'
    last_response.should be_ok
  end

  it 'displays all the lessons specified in the JSON file' do

    lessons_list.each do |lesson_info|
      last_response.body.should include lesson_info["title"]
    end
  end

  it 'displays the lessons sorted by category' do
    lessons_list.each do |lesson_info|
      last_response.body.should include lesson_info["category"]
    end
  end
end

describe 'lesson page' do
  it 'displays the specific lesson required in the lessons page' do
    lessons = Lesson.get_lessons_from_files
    lessons.each do |lesson|
      get "/lessons/#{lesson.title.parameterize}"
      last_response.body.should include lesson.title
    end
  end
end

# class LearningPlatformExercisesPageTest < Test::Unit::TestCase
# 
#   def test_it_loads_the_exercises_page
#     get '/exercises' 
#     assert last_response.ok?
#     assert last_response.body.include?('Exercices')
#   end
# end
