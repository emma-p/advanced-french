#encoding:utf-8
require_relative 'dependencies'

class LearningPlatform < Sinatra::Base
  enable :sessions
  set :session_secret, "My session secret"
  use Rack::Flash

  helpers ExercisePresenter

  get '/' do
    haml :index
  end

  get '/about' do
    haml :about
  end

  get '/lessons' do
    @lessons = LessonsFetcher.new.get_lessons
    @categories = LessonsFetcher.new.get_categories
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
    if logged_in
      user_answer_service = UserAnswerService.new session[:email]
      @answered_questions = user_answer_service.get_user_answers_for @exercise
    end
    haml :exercise
  end

  post '/exercises/:exercise_title' do
    @exercise = ExercisesFetcher.new.find_exercise params[:exercise_title]
    @questions = @exercise.questions
    answers = params.select{|k,v| k =~ /attempt_/}
    session.merge!(answers)
    if logged_in
      user_answer_service = UserAnswerService.new session[:email]
      user_answer_service.save_user_answers(@exercise, answers_to_save(questions_status))
    end
    redirect to("/exercises/#{params[:exercise_title]}")
  end

  get '/login' do
    if logged_in
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
    session.clear
    redirect to("/")
  end

  private

  def logged_in
    !!session[:email]
  end

end
