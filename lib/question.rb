class Question
  attr_reader :exercise_title, :number, :content, :answer, :hint
  attr_accessor :status
  
  def initialize exercise_title, number, content, answer, hint
    @exercise_title = exercise_title
    @number = number
    @content = content
    @answer = answer
    @hint = hint
  end
end
