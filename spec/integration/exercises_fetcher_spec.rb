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
  end

  describe ExercisesFetcher do
    
    it 'returns all the exercises from the database as Exercise objects with Question objects'do
      exercises_ids = subject.get_exercises.map {|exercise| exercise.id}
      exercises_ids.should == [1, 2]
    end

    it 'finds an exercise by its parameterized name' do
      subject.find_exercise("1").title.should == "Conditionnel ou indicatif?"
    end    
  end
end
