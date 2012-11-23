#encoding:utf-8
require_relative 'dependencies'

class LearningPlatform < Sinatra::Base
  enable :sessions
  set :session_secret, "My session secret"
  use Rack::Flash

  helpers ExerciseHelper

  before do
    if params[:username] && params[:password]
      if Bouncer.user_can_authenticate? params["username"], params["password"]
        session["userid"] = params["username"]
        @user = User.new session["userid"]
      end
    end
  end

  get '/' do
    haml :index
  end

  get '/about' do
    haml :about
  end

  get '/lessons' do
    @categories = CategoriesFetcher.new.get_categories
    haml :lessons 
  end

  get '/lessons/:lesson_name' do
    @categories = CategoriesFetcher.new.get_categories
    haml "lessons-folder/#{params[:lesson_name]}".to_sym
  end

  get '/exercises' do
    @exercises = ExercisesFetcher.new.get_exercises
    haml :exercises
  end

  get '/exercises/:exercise_title' do
    @exercise = ExercisesFetcher.new.find_exercise params[:exercise_title]
    @questions = @exercise.questions
    user_answers = UserDataFetcher.new  
    haml :exercise
  end

  post '/exercises/:exercise_title' do
    @exercise = ExercisesFetcher.new.find_exercise params[:exercise_title]
    @questions = @exercise.questions
    answers = params.select{|k,v| k =~ /user_answer_/}
    session.merge!(answers)
    redirect to("/exercises/#{params[:exercise_title]}")
  end

  get '/login' do
    if session["userid"]
      redirect to("/")
    else
      haml :login
    end
  end

  post '/login' do
    if @user
      redirect to("/")
    else
      flash[:error_message] = "Wrong email or password, please try again"
      redirect to("/login")
    end
  end

  get '/signout' do
    session["userid"] = nil
    redirect to("/")
  end
end
