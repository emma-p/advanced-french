class UserDataFetcher < Struct.new(:user)
  def get_user_answers
    user.data["user_answers"]
  end
end
