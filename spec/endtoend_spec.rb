require_relative '../learning_platform'
require_relative 'spec_helper'
require_relative '../lesson.rb'
require_relative '../exercise.rb'
require_relative '../lib/categories_fetcher.rb'
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

  before do 
    get '/lessons'
    last_response.should be_ok
  end

  it 'displays all the lessons specified in the JSON file'

  it 'displays the lessons sorted by category'
end

describe 'lesson page' do

  it 'displays the specific lesson required in the lessons page'
end

describe 'exercises page' do
  it 'displays all the exercises specified in the JSON file'
end

describe 'exercise page' do
  let(:exercises) {Exercise.get_exercises_from_files}

  it 'displays the specific exercise required in the exercises page'

end
