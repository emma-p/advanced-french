#encoding:utf-8
require_relative 'spec_helper'

include Rack::Test::Methods
include SpecHelper

def app
  LearningPlatform
end

describe 'end to end' do
  before do
    load_lessons_exercises_and_users
  end

  after do
    drop_collections ["exercises", "lessons", "users"]
  end

  describe 'home page' do
    it 'loads the index' do
      get '/'
      last_response.should be_ok
    end
  end

  describe 'lessons page' do
    it 'displays all the lessons' do
      get '/lessons'

      last_response.should be_ok
      last_response.body.should include "Adverbes" #title
      last_response.body.should include "Grammaire" #category
    end
  end

  describe 'lesson page' do
    it 'displays the specific lesson required in the lessons page' do
      get "/lessons/adverbes"
      last_response.should be_ok
      last_response.body.should include "Adverbes"
    end
  end
  describe 'exercises page' do


    it 'displays all the exercises available in the exercises folder' do
      get '/exercises'
      last_response.should be_ok
      last_response.body.should include "Conditionnel ou indicatif?"
    end
  end

  describe 'exercise page' do

    it 'displays the specific exercise required in the exercises page' do
      get "/exercises/conditionnel-ou-indicatif"
      last_response.should be_ok
      last_response.body.should include "Conditionnel ou indicatif?"
      last_response.body.should include "Marianne a affirmé qu'elle viendrait"
    end
  end

  describe 'login' do
    it 'allows a signed up user to login' do
      parameters = {email: "foo@bar.com", password: "pass"}
      post "/login", parameters
      follow_redirect!
      last_response.should be_ok
      last_response.body.should include "Logged in as foo@bar.com"
      last_response.body.should include "Sign out"
    end

    it 'does not allow a non signed up user to login' do
      parameters = {email: "four@bar.com", password: "pass"}
      post "/login", parameters
      follow_redirect!
      last_response.body.should include "Wrong email or password"
      last_response.body.should include "Login"
    end

    it 'does not allow a signed up user to try to login again' do
      parameters = {email: "foo@bar.com", password: "pass"}
      post "/login", parameters
      follow_redirect!
      get "/login"
      follow_redirect!
      last_response.should be_ok
      last_response.body.should include "Browse our lessons with topics"
    end
  end

  describe 'signout' do
    it 'disconnects a logged in user' do
      parameters = {email: "foo@bar.com", password: "pass"}
      post "/login", parameters
      follow_redirect!
      get '/signout'
      follow_redirect!
      last_response.body.should_not include "Logged in as foo@bar.com"
      last_response.body.should include "Login"
    end
  end
end
