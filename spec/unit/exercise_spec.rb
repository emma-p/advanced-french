#encoding:utf-8
require_relative '../spec_helper'

describe Exercise do
  let (:exercise_title) { "Révisez les fondamentaux de la conjugaison!"}
  subject { Exercise.new 3, exercise_title}
    
  describe '#name' do
    it 'parameterizes the exercise title' do
      subject.name.should == "revisez-les-fondamentaux-de-la-conjugaison"
    end
  end

  describe '#url' do
    it 'returns a /exercises/exercise_name path' do
      subject.url.should == '/exercises/revisez-les-fondamentaux-de-la-conjugaison' 
    end
  end
end
