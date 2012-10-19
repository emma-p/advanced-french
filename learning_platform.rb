#encoding:utf-8

require 'sinatra'
require 'active_support/all'
require 'json'
require 'pry'
require_relative 'lesson.rb'
require_relative 'exercise.rb'
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
  @exercises = Exercise.get_exercises_from_files
  haml :exercises
end

get '/exercises/:exercise_name' do
  #exercise_file = File.read("data/exercises/#{params[:exercise_name]}.json")
  #@exercise_content = JSON.parse(exercise_file)
  #@questions = @exercise_content["questions"]
  @exercise = Exercise.new params[:exercise_name]
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
