require_relative 'parser_module.rb'
require_relative 'exercise.rb'

class ExercisesFetcher
  include Parser
  EXERCISES_FILES_PATHS = Dir.glob('data/exercises/*.json')

  def get_exercises_from_files
    EXERCISES_FILES_PATHS.map do |file|
      exercise = parse_json_file file
      title = exercise["title"]
      questions = exercise["questions"].map do |question|
        Question.new title, question["question_number"], question["content"], question["answer"], question["hint"]
      end
      Exercise.new title, questions
    end
  end

  def find_exercise name
    get_exercises_from_files.find { |exercise| exercise.name == name }
  end
end
