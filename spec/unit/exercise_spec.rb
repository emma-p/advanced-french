#encoding:utf-8
require_relative '../spec_helper'

describe Exercise do
  let (:exercise_title) { "Révisez les fondamentaux de la conjugaison!"}
  let (:exercise_questions) { "" }
  let (:exercise) { Exercise.new exercise_title, exercise_questions}
    
  describe '#name' do
    it 'parameterizes the exercise title' do
      exercise.name.should == "revisez-les-fondamentaux-de-la-conjugaison"
    end
  end

  describe '#url' do
    it 'returns a /exercises/exercise_name path' do
      exercise.url.should == '/exercises/revisez-les-fondamentaux-de-la-conjugaison' 
    end
  end
end
