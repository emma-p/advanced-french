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
  end

  it 'displays all the lessons specified in the JSON file' do
    last_response.should be_ok
    parsed_json_file.each do |lesson|
      last_response.body.should include lesson["title"]
      last_response.body.should include lesson["category"]
    end
  end
end

describe 'lesson page' do

  let(:parsed_json_file) {parse_json_file "data/lessons.json"} 

  it 'displays the specific lesson required in the lessons page' do
    parsed_json_file.each do |title, category|
      get "/lessons/#{title['title'].parameterize}"
      last_response.should be_ok
      last_response.body.should include title["title"]
    end
  end
end
describe 'exercises page' do

  before do
    get '/exercises'
  end

  it 'displays all the exercises available in the exercises folder' do
    exercise_files = Dir.glob('data/exercises/*.json')
    last_response.should be_ok
    exercise_files.each do |exercise|
      file = parse_json_file exercise
      last_response.body.should include file["title"]
    end
  end
end

describe 'exercise page' do

  it 'displays the specific exercise required in the exercises page' do
    exercises_files_paths = Dir.glob('data/exercises/*.json')
    exercises_files_paths.each do |file|
      exercise = parse_json_file file      
      get "exercises/#{exercise['title'].parameterize}"
      last_response.should be_ok
      last_response.body.should include exercise["title"]
      last_response.body.should include exercise["questions"]["content"].split("__") 
    end
  end
end
