require_relative '../learning_platform'
require_relative 'spec_helper'
require_relative '../lib/lesson.rb'
require_relative '../lib/exercise.rb'
require_relative '../lib/categories_fetcher.rb'
require_relative '../lib/parser_module'

include Rack::Test::Methods
include Parser

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

  let(:parsed_json_file) {parse_json_file "data/lessons.json"} 

  before do 
    get '/lessons'
    last_response.should be_ok
  end

  it 'displays all the lessons specified in the JSON file' do
    puts parsed_json_file
    parsed_json_file.each do |title, category|
      last_response.body.should include title["title"]
      last_response.body.should include title["category"]
    end
  end
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
