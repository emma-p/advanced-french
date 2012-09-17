require 'sinatra'

get '/' do
  haml :index
end

get '/learning_materials/:material_name' do
  haml params[:material_name].to_sym
end
  
