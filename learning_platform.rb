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
  if request["answer1"] == "rats"
    "Vous avez donné la bonne réponse!"
  else
    "Désolé, la bonne réponse était rats."
  end
end
