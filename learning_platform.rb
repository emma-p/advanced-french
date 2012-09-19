#encoding:utf-8

require 'sinatra'
require 'active_support/all'

get '/' do
  haml :index
end

get '/lessons' do
  @lessons = { Grammaire: ['Adverbes', 'Conditionnel'], Orthographe: ['Accents', 'Mots à ne pas confondre', 'Courriels']}
  haml :lessons 
end

get '/lessons/:lesson_name' do
  haml params[:lesson_name].to_sym
end

get '/exercises' do
  haml :exercises
end
