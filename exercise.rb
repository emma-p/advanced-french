class Exercise
  attr_accessor :title, :questions

  def initialize title, questions
    @title = title
    @questions = questions
  end

  def self.get_exercises_from_files
    exercises_file_paths = Dir.glob('data/exercises/*.json')
    exercises_file_paths.map do |f|
      result = File.read f
      Exercise.new JSON.parse(result)["title"], JSON.parse(result)["questions"]
    end
  end
end
