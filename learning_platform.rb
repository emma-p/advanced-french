#encoding:utf-8
['lib', File.dirname(__FILE__)].each { |path| $: << path }

require 'bundler'
Bundler.require

require 'active_support/all'
require 'connection'
require 'lesson'
require 'question'
require 'exercise'
require 'categories_fetcher'
require 'exercises_fetcher'
require 'views/helpers/exercise_helper'
require 'category'

class LearningPlatform < Sinatra::Base
  enable :sessions

  helpers ExerciseHelper

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
    @exercises = ExercisesFetcher.new.get_exercises
    haml :exercises
  end

  get '/exercises/:exercise_title' do
    @exercise = ExercisesFetcher.new.find_exercise params[:exercise_title]
    @questions = @exercise.questions
    haml :exercise
  end

  post '/exercises/:exercise_title' do
    @exercise = ExercisesFetcher.new.find_exercise params[:exercise_title]
    @questions = @exercise.questions
    answers = params.select{|k,v| k =~ /user_answer_/}
    session.merge!(answers)
    redirect to("/exercises/#{params[:exercise_title]}")
  end
end
