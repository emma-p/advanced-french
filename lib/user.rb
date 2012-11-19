class User < Struct.new(:username, :user_answers)
  def get_user_answers
    user_hash = Connection.db["users"].find_one({"username" => username})
    user_answers = user_hash["answers"]
  end
end
