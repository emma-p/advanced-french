#encoding:utf-8
require_relative 'dependencies'

class LearningPlatform < Sinatra::Base
  enable :sessions
  set :session_secret, "My session secret"
  use Rack::Flash

  helpers ExerciseHelper

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
    haml "lessons-folder/#{params[:lesson_name]}".to_sym
  end

  get '/exercises' do
    @exercises = ExercisesFetcher.new.get_exercises
    haml :exercises
  end

  get '/exercises/:exercise_title' do
    @exercise = ExercisesFetcher.new.find_exercise params[:exercise_title]
    @questions = @exercise.questions
    if session[:email]
      user_answer_service = UserAnswerService.new User.new session[:email]
      @user_answers = user_answer_service.get_user_answers.select{|exercise| exercise["exercise_id"] == @exercise.id}.fetch(0)
      @answered_questions = @user_answers["answered_questions"] 
    end
    haml :exercise
  end

  post '/exercises/:exercise_title' do
    @exercise = ExercisesFetcher.new.find_exercise params[:exercise_title]
    @questions = @exercise.questions
    answers = params.select{|k,v| k =~ /attempt_/}
    session.merge!(answers)
    redirect to("/exercises/#{params[:exercise_title]}")
  end

  get '/login' do
    if session["email"]
      redirect to("/")
    else
      haml :login
    end
  end

  post '/login' do
    if Bouncer.user_can_authenticate? params["email"], params["password"]
      session["email"] = params["email"]
      redirect to("/")
    else
      flash[:error_message] = "Wrong email or password, please try again"
      redirect to("/login")
    end
  end

  get '/signout' do
    session["email"] = nil
    redirect to("/")
  end
end
