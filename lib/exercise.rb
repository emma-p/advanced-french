require_relative 'question.rb'
require_relative 'parser_module.rb'

class Exercise
  include Parser
  attr_accessor :title, :questions

  def initialize title
    parsed_exercise_file = parse_json_file("data/exercises/#{title}.json")
    @title = parsed_exercise_file["title"]
    question_array = parsed_exercise_file["questions"]
    @questions = question_array.map do |question|
      Question.new @title, question["question_number"], question["content"], question["answer"], question["hint"]
    end
  end

  def url
    "/exercises/#{title.parameterize}"
  end

end

