require_relative 'question.rb'

class Exercise
  attr_accessor :title, :questions

  EXERCISES_FILES_PATHS = Dir.glob('data/exercises/*.json')

  def initialize title
    exercise_file = File.read("data/exercises/#{title}.json")
    exercise_content = JSON.parse(exercise_file)
    @title = exercise_content["title"]
    @questions = exercise_content["questions"]
    @questions.each do |question|
      Question.new @title, question["question_number"]
    end
  end

  def self.get_exercises_from_files
    EXERCISES_FILES_PATHS.map do |f|
      exercise_file = File.read f
      title = JSON.parse(exercise_file)["title"].parameterize
      Exercise.new title
    end
  end
end

