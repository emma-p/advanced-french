class UserDataFetcher < Struct.new(:user)
  def get_user_answers
    user_data = Connection.db["users"].find_one({"username" => user["username"]})
    user_data["user_answers"]
  end
end
