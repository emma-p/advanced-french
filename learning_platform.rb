#encoding:utf-8

require 'sinatra'
require 'active_support/all'
require_relative 'lessons'

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
  haml :exercises
end

post '/exercises' do
  @answer1 = request["answer1"]
  haml :exercises
end
