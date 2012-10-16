#encoding:utf-8

require 'sinatra'
require 'active_support/all'
require 'json'
require 'pry'
require_relative 'lesson.rb'

enable :sessions

get '/' do
  haml :index
end

get '/lessons' do
  @lessons = Lesson.get_lessons_from_files
  haml :lessons 
end

get '/lessons/:lesson_name' do
  haml "lessons-folder/#{params[:lesson_name]}".to_sym
end

get '/exercises' do
  exercises_file_paths = Dir.glob('data/exercises/*.json')
  @exercises = exercises_file_paths.map do |f|
    result = File.read f
    JSON.parse(result)["title"]
  end
  haml :exercises
end

get '/exercises/:exercise_name' do
  exercise_file = File.read("data/exercises/#{params[:exercise_name]}.json")
  @exercise_content = JSON.parse(exercise_file)
  @questions = @exercise_content["questions"]
  haml :exercise
end

post '/exercises/:exercise_name' do
  exercise_file = File.read("data/exercises/#{params[:exercise_name]}.json")
  @exercise_content = JSON.parse(exercise_file)
  @questions = @exercise_content["questions"]
  @questions.each do |question, data|
    session[question] = request[question]
  end
  redirect to("/exercises/#{params[:exercise_name]}")
end
