#encoding:utf-8
require_relative '../spec_helper'

include SpecHelper

describe 'integration' do
  before do
    load_lessons_and_exercises
    create_user_foo
  end

  after do
    drop_all_collections
    remove_user_foo
  end

  describe UserAnswerService do
    let (:user_answer_service) { UserAnswerService.new 'foo@bar.com' }
    let (:exercise) { double('exercise', :id => 1)}

    it 'returns the user answers stored in the database' do
      user_answer_service.get_user_answers_for(exercise).should == [1,2,4]
    end

    it 'saves the correct answers in the database' do
      answers = [9,10]
      user_answer_service.save_user_answers(exercise, answers)
      user_answer_service.get_user_answers_for(exercise).should == [1,2,4,9,10]
    end
  end

end
