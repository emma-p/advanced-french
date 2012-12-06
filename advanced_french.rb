#encoding:utf-8
require_relative 'dependencies'

class AdvancedFrench < Sinatra::Base
  enable :sessions
  set :session_secret, "My session secret"
  use Rack::Flash

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

  get '/exercises/:exercise_id' do
    @exercise = ExercisesFetcher.new.find_exercise params[:exercise_id]
    @questions = @exercise.questions

    already_answered = if logged_in
                         uas = answer_service
                         uas.get_user_answers_for @exercise
                       else
                         []
                       end

    @questions.each do |q|
      q.status = case session["answer_#{q.number}"]
                 when q.answer ; "answered"
                 when nil, ""  ; "unanswered"
                 else          ; "misanswered"
                 end

      q.status = "answered" if already_answered.include?(q.number)
    end

    haml :exercise
  end

  post '/exercises/:exercise_id' do
    @exercise = ExercisesFetcher.new.find_exercise params[:exercise_id]
    @questions = @exercise.questions
    answers = params.select{|k,v| k =~ /answer_/}
    session.merge!(answers)
    if logged_in
      uas = answer_service
      uas.save_right_answers @exercise, answers
    end
    redirect to("/exercises/#{params[:exercise_id]}")
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
      session.clear
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
    !!session["email"]
  end

  def answer_service
    UserAnswerService.new session["email"]
  end

end
