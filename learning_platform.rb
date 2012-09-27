#encoding:utf-8

require 'sinatra'
require 'active_support/all'
require 'json'
require_relative 'lessons'
require_relative 'exercises'

enable :sessions

get '/' do
  haml :index
end

get '/lessons' do
  haml :lessons 
end

get '/lessons/:lesson_name' do
  haml "lessons-folder/#{params[:lesson_name]}".to_sym
end

get '/exercises' do
  @exercises = ExercisesManifest::EXERCISES
  exercise_file = File.read('exercises_content.json')
  @output = JSON.parse(exercise_file)
  haml :exercises
end

post '/exercises' do
  @exercises_keys = ExercisesManifest::EXERCISES.keys
  @exercises_keys.each do |question|
    session[question] = request[question]
  end
  redirect to('/exercises')
end
