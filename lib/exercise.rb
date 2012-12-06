class Exercise 
  attr_reader :id, :title, :questions

  def initialize id, title, questions
    @id = id
    @title = title
    @questions = questions
  end

  def find_question question_number
    questions.find do |q|
      q.number == question_number
    end
  end
end
