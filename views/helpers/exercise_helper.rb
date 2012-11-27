module ExerciseHelper

  def question_presentation
    @questions.map do |question|
      attempt_number = "attempt_#{question.number}"
      attempt = session[attempt_number]
      is_already_answered = @answered_questions && @answered_questions.include?(question.number)
      if is_already_answered || attempt == question.answer
        {question: question, status: "answered"}
      elsif attempt.blank?
        {question: question, status: "unanswered"}
      else
        {question: question, status: "misanswered"}
      end
    end
  end
end
