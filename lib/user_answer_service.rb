class UserAnswerService
  attr_reader :user_email
  
  def initialize user_email
    @user_email = user_email
  end

  def get_user_answers_for exercise
    user_data = Connection.db["users"].find_one({"email" => user_email})
    user_answers = user_data["user_answers"]
    answers_for_exercise = user_answers.select{|ex| ex["exercise_id"] == exercise.id}
    if answers_for_exercise.size > 0 
      answers_for_exercise.fetch(0)["answered_questions"]
    else
      []
    end
  end

  def save_right_answers exercise, answers
    answer_ids = answers.keys.map do |answer|
      answer.scan(/\d+/).first.to_i
    end

    right_answer_ids = answer_ids.select do |q_id|
      right_answer = exercise.find_question(q_id).try(:answer)
      answers["answer_#{q_id}"] == right_answer
    end

    save_user_answers exercise, right_answer_ids
  end

  def save_user_answers exercise, answer_numbers
    user_answers = get_user_answers_for exercise 
    new_answers = (user_answers | answer_numbers).sort
    Connection.db["users"].update({"email" => user_email}, {'$set' => {"user_answers" => [{"exercise_id" => exercise.id, "answered_questions" => new_answers} ] } } ) 
  end
end
