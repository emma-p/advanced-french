namespace "db" do
  desc "add new user"
  task "add_user" => "environment" do
    db = Connection.db
    email = ENV['email']
    password = ENV['password']
    raise 'please provide valid email and password' unless email && password
    raise 'user already created' if db["users"].find_one("email" => email)
    db["users"].insert({"email" => email, "password" => password, "user_answers" => []})
    puts "user #{email} created successfully!"
  end

  desc "delete user"
  task "delete_user" => "environment" do
    db = Connection.db
    email = ENV['email']
    raise 'please provide a valid email' unless email
    raise 'user does not exist' unless db["users"].find_one("email" => email)
    db["users"].remove("email" => email)
    puts "user #{email} deleted"
  end

  desc "seed database"
  task "seed" => "clean" do
    LESSONS_FILE = 'data/lessons.json'
    EXERCISES_FOLDER = 'data/exercises/'

    db = Connection.db

    puts "inserting lessons..."
    db["lessons"].insert JSON.parse(File.read LESSONS_FILE)
    puts "done"

    puts "inserting exercises..."
    Dir.glob(EXERCISES_FOLDER + "**/*.json").each do |f|
      db["exercises"].insert JSON.parse(File.read f)
    end
    puts "done"
  end

  desc "drop the current collections"
  task "clean" => "environment" do
    puts 'connecting...'
    db = Connection.db
    puts 'connected'
    collections = ["exercises", "lessons"]
    collections.each do |col|
      puts "deleting #{col}..."
      db[col].drop
      puts "done"
    end
    puts "collections cleaned"
  end
  
  desc "load the environment"
  task "environment" do
    ENV['RACK_ENV'] ||= 'development'
    require_relative 'dependencies'
  end
end
