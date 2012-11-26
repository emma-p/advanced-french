describe 'integration' do
  before do
    load_lessons_exercises_and_users
  end

  after do
    drop_collections ["exercises", "lessons", "users"]
  end

  describe ExercisesFetcher do
    let (:exercises_fetcher) {ExercisesFetcher.new}
    
    describe '#get_exercises' do
      it 'returns all the exercises from the database as Exercise objects with Question objects'do
        exercises_titles = exercises_fetcher.get_exercises.map {|exercise| exercise.title}
        exercises_titles.should == ["Conditionnel ou indicatif?", "Verbes difficiles du premier groupe"]
      end
    end

    describe '#find_exercise' do
      it 'finds an exercise by its parameterized name' do
        exercises_fetcher.find_exercise("conditionnel-ou-indicatif").title.should == "Conditionnel ou indicatif?"
      end    
    end
  end
end
