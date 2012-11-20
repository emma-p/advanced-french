class User < Struct.new(:username, :password)
  def data
    Connection.db["users"].find_one({"username" => username})
  end
end 
