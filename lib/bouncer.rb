class Bouncer
  def self.user_can_authenticate? email, password
    return false unless user = Connection.db["users"].find_one("email" => email)
    password_to_verify = Digest::SHA2.hexdigest(user["salt"] + password)
    password_to_verify == user["password"]
  end
end
