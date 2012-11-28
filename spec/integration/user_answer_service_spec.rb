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

    describe "#save_user_answers" do
      it 'saves the correct answers in the database' do
        user = User.new 'foo@bar.com'
        user_answer_service = UserAnswerService.new user
        exercise = ExercisesFetcher.new.find_exercise('conditionnel-ou-indicatif')
        answers = [9,10]
        submitted_answers = user_answer_service.save_user_answers(exercise, answers)
        user_answer_service.get_user_answers_for(exercise).should == [1,2,4,9,10]
      end
    end
  end

end
