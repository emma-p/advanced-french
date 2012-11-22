#encoding:utf-8
require_relative '../spec_helper'

include SpecHelper

describe 'integration' do
  before do
    load_lessons_exercises_and_users
  end

  after do
    drop_collections ["exercises", "lessons", "users"]
  end

  describe UserDataFetcher do
    describe "#get_user_answers" do
      it 'returns the user answers stored in the database' do
        user = User.new 'test_username'
        user_data_fetcher = UserDataFetcher.new user
        user_data_fetcher.get_user_answers.first.should == {"exercise_title" => "Conditionnel ou indicatif?", "answered_questions" => [1,2,4]}
      end
    end
  end

  describe "#give_user_answers" do
    it 'passes the user answers to Sinatra in order to be rendered in the views'
  end
end
