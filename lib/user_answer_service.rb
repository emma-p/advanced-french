class UserAnswerService < Struct.new(:user)
  def get_user_answers
    user_data = Connection.db["users"].find_one({"email" => user.email})
    user_data["user_answers"]
  end
end
