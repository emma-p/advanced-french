module ViewHelper
  def bold text
    "<b>#{text}</b>"
  end
  def substitute_answer question, user_answer_number, hint
    question.gsub('__', "<input type='form', name='#{user_answer_number}', value= ''></input> (#{bold(hint)})")
  end
  def wrong_answer string
    "<p>#{string} <i class='icon-remove'></i></p>"
  end
  def good_answer string
    "<p>#{string} <i class='icon-ok'></i></p>"
  end
end
