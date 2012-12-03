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
      exercises_titles = subject.get_exercises.map {|exercise| exercise.title}
      exercises_titles.should == ["Conditionnel ou indicatif?", "Verbes difficiles du premier groupe"]
    end

    it 'finds an exercise by its parameterized name' do
      subject.find_exercise("conditionnel-ou-indicatif").title.should == "Conditionnel ou indicatif?"
    end    
  end
end
