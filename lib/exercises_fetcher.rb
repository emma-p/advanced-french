require_relative 'parser_module.rb'
require_relative 'exercise.rb'

class ExercisesFetcher
  include Parser
  EXERCISES_FILES_PATHS = Dir.glob('data/exercises/*.json')

  def get_exercises_from_files
    EXERCISES_FILES_PATHS.map do |file|
      exercise = parse_json_file file
      title = exercise["title"].parameterize
      Exercise.new title
    end
  end
end
