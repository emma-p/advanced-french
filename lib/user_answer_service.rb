class UserAnswerService < Struct.new(:user)
  def get_user_answers_for exercise
    user_data = Connection.db["users"].find_one({"email" => user.email})
    user_answers = user_data["user_answers"]
    answers_for_exercise = user_answers.select{|ex| ex["exercise_id"] == exercise.id}
    if answers_for_exercise.size > 0 
      answers_for_exercise.fetch(0)["answered_questions"]
    else
      []
    end
  end

  def save_user_answers exercise, answers
    user_answers = get_user_answers_for exercise 
    new_answers = (user_answers | answers).sort
    Connection.db["users"].update({"email" => user.email}, {'$set' => {"user_answers" => [{"exercise_id" => exercise.id, "answered_questions" => new_answers} ] } } ) 
  end
end
