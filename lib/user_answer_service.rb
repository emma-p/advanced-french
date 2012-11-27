class UserAnswerService < Struct.new(:user)
  def get_user_answers_for exercise
    user_data = Connection.db["users"].find_one({"email" => user.email})
    user_answers = user_data["user_answers"]
    answers_for_exercise = user_answers.select{|ex| ex["exercise_id"] == exercise.id}.fetch(0)
    answers_for_exercise["answered_questions"]
  end
end
