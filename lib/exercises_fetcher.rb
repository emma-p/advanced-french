class ExercisesFetcher
  def get_exercises
    exercises = Connection.db["exercises"]
    exercises.find.map do |exercise|
      title = exercise["title"]
      questions = exercise["questions"].map do |question|
        Question.new title, question["question_number"], question["content"], question["answer"], question["hint"]
      end
      Exercise.new title, questions
    end
  end

  def find_exercise name
    get_exercises.find { |exercise| exercise.name == name }
  end
end
