require_relative '../learning_platform'
require_relative 'spec_helper'
require_relative '../lesson.rb'
require_relative '../exercise.rb'

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
  let(:lessons_list) { Lesson.get_lessons_from_files }

  before do 
    get '/lessons'
    last_response.should be_ok
  end

  it 'displays all the lessons specified in the JSON file' do
    lessons_list.each do |lesson|
      last_response.body.should include lesson.title
    end
  end

  it 'displays the lessons sorted by category' do
    lessons_list.each do |lesson|
      last_response.body.should include lesson.category
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

describe 'exercises page' do
  let(:exercises_list) { Exercise.get_exercises_from_files }

  it 'displays all the exercises specified in the JSON file' do
    get '/exercises' 
    last_response.should be_ok
    exercises_list.each do |exercise|
      last_response.body.should include exercise.title
    end
  end
end
