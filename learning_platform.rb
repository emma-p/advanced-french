#encoding:utf-8

require 'sinatra'
require 'active_support/all'
require 'json'
require 'pry'
require_relative 'lib/lesson.rb'
require_relative 'lib/exercise.rb'
require_relative 'lib/categories_fetcher'
require_relative 'lib/exercises_fetcher'
enable :sessions

get '/' do
  haml :index
end

get '/lessons' do
  @categories = CategoriesFetcher.new.get_categories
  haml :lessons 
end

get '/lessons/:lesson_name' do
  haml "lessons-folder/#{params[:lesson_name]}".to_sym
end

get '/exercises' do
  @exercises = ExercisesFetcher.new.get_exercises_from_files
  haml :exercises
end

get '/exercises/:exercise_title' do
  all_exercises = ExercisesFetcher.new.get_exercises_from_files
  @exercise = all_exercises.find { |exercise| exercise.name == params[:exercise_title] }
  @questions = @exercise.questions
  haml :exercise
end

post '/exercises/:exercise_title' do
  all_exercises = ExercisesFetcher.new.get_exercises_from_files
  @exercise = all_exercises.find { |exercise| exercise.name == params[:exercise_title] }
  @questions = @exercise.questions
  @questions.each do |question|
    session["user_answer_#{question.question_number}"] = request["user_answer_#{question.question_number}"] 
  end
  redirect to("/exercises/#{params[:exercise_title]}")
end
