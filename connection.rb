class Connection
  def self.db
    @db ||= get_db
  end

  def self.get_db
    if ENV['RACK_ENV'] == 'production'
      db_info = URI.parse(ENV['MONGOHQ_URL'])
      db_name = db_info.path.gsub(/^\//, '')
      db = Mongo::Connection.new(db_info.host, db_info.port).db(db_name) 
      db.authenticate(db_info.user, db_info.password) unless (db_info.user.nil? || db_info.user.nil?) 
      db
    else
      db = Mongo::Connection.new.db "advanced_french_#{ENV['RACK_ENV']}_db", safe: true
    end
  end
end
