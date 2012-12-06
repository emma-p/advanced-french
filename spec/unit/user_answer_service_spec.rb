require_relative '../../lib/user_answer_service'
require 'active_support/all'
require 'ostruct'

describe UserAnswerService do
  describe '#save_right_answers' do
    let(:uas)      { UserAnswerService.new 'foo@bar.com' }
    let(:question) { OpenStruct.new(answer: "answer") }
    let(:exo)      { OpenStruct.new(id: 1) }

    before do
      exo.stub(:find_question).with(1).and_return question
      exo.stub(:find_question).with(2).and_return nil
    end
    
    it 'saves the right answers' do
      answers = {"answer_1" => "answer"}

      uas.should_receive(:save_user_answers).with(exo, [1])

      uas.save_right_answers exo, answers
    end

    it 'does not save the wrong answers' do
      answers = {"answer_1" => "wrong answer"}

      uas.should_receive(:save_user_answers).with(exo, [])

      uas.save_right_answers exo, answers
    end

    it 'does not save answers for unexisting questions' do
      answers = {"answer_2" => "answer"}

      uas.should_receive(:save_user_answers).with(exo, [])

      uas.save_right_answers exo, answers
    end
  end
end
