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

  describe UserAnswerService do
    describe "#get_user_answers_for" do
      it 'returns the user answers stored in the database' do
        user = User.new 'foo@bar.com'
        user_answer_service = UserAnswerService.new user
        exercise = ExercisesFetcher.new.find_exercise 'conditionnel-ou-indicatif' 
        user_answer_service.get_user_answers_for(exercise).should == [1,2,4]
      end
    end
  end

end
