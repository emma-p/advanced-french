namespace "db" do
  desc "seed production database"
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
    collections = db.collection_names
    collections.delete 'system.indexes'
    collections.each do |col|
      puts "deleting #{col}..."
      db[col].drop
      puts "done"
    end
    puts "collections cleaned"
  end
  
  desc "load the environment"
  task "environment" do
    require_relative 'dependencies'
  end
end
