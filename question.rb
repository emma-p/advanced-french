class Question
  attr_accessor :exercise_title, :question_number

  def initialize exercise_title, question_number
    @exercise_title = exercise_title
    @question_number = question_number
  end

  def display_content
  end
end
