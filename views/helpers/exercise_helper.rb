module ExerciseHelper

  def boldify text
    "<b>#{text}</b>"
  end

  def add_ok_icon string
    "<p>#{string} <i class='icon-ok'></i></p>"
  end

  def add_wrong_icon string
    "<p>#{string} <i class='icon-remove'></i></p>"
  end

  def create_form_input name
    "<input type='form', name='#{name}', value= ''></input>"
  end

  def answered question
    add_ok_icon question.content.gsub('__', "#{boldify question.answer}")
  end

  def wrong_answered question
    attempt_number = "attempt_#{question.number}"
    add_wrong_icon question.content.gsub('__', "#{create_form_input attempt_number} (#{boldify question.hint})")
  end

  def unanswered question
    attempt_number = "attempt_#{question.number}"
    question.content.gsub('__', "#{create_form_input attempt_number} (#{boldify question.hint})")
  end

  def display_questions
    @questions.map do |question|
      attempt_number = "attempt_#{question.number}"
      attempt = session[attempt_number]
      if session[:email] && @answered_questions.include?(question.number)
        answered question
      elsif attempt == question.answer
        answered question
      elsif attempt != nil && attempt != "" && attempt != question.answer
        wrong_answered question
      else
        unanswered question
      end
    end
  end
end
