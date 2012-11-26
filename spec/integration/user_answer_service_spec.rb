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
    describe "#get_user_answers" do
      it 'returns the user answers stored in the database' do
        user = User.new 'foo@bar.com'
        user_answer_service = UserAnswerService.new user
        user_answer_service.get_user_answers.first.should == {"exercise_id" => 1, "answered_questions" => [1,2,4]}
      end
    end
  end

end
