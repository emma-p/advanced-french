class Bouncer
  def self.user_can_authenticate? username, password
    Connection.db["users"].find_one({"username" => username, "password" => password})
  end
end
