require 'sinatra'
require 'active_support/all'

get '/' do
  haml :index
end

get '/lessons' do
  haml :lessons
end

get '/lessons/:lesson_name' do
  haml params[:lesson_name].to_sym
end

get '/exercises' do
  haml :exercises
end
