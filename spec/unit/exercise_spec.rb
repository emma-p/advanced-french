#encoding:utf-8
require_relative '../spec_helper'

describe Exercise do
  subject { Exercise.new 3, "Révisez les fondamentaux de la conjugaison"}
    
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
