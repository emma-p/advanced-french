module ExerciseHelper
  def boldify text
    "<b>#{text}</b>"
  end

  def add_good_answer_icon string
    "<p>#{string} <i class='icon-ok'></i></p>"
  end

  def add_wrong_answer_icon string
    "<p>#{string} <i class='icon-remove'></i></p>"
  end

  def create_form_input name
    "<input type='form', name='#{name}', value= ''></input>"
  end
end
