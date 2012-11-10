class Connection
  @db = Mongo::Connection.new.db "learning_platform_db", safe: true

  def self.db
    @db
  end
end
