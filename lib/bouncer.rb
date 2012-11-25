class Bouncer
  def self.user_can_authenticate? email, password
    Connection.db["users"].find_one({"email" => email, "password" => password})
  end
end
