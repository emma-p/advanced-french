#encoding:utf-8
ENV['RACK_ENV'] = 'test'
require_relative '../learning_platform'

module SpecHelper
  TEST_LESSONS_FILE = 'spec/spec_data/lessons.json'
  TEST_EXERCISES_FOLDER = 'spec/spec_data/exercises/'
  TEST_USERS_FILE = 'spec/spec_data/users.json'

  def load_lessons_exercises_and_users
    db = Connection.db

    db["lessons"].insert JSON.parse(File.read TEST_LESSONS_FILE)

    db["users"].insert JSON.parse(File.read TEST_USERS_FILE)

    Dir.glob(TEST_EXERCISES_FOLDER + "**/*.json").each do |f|
      db["exercises"].insert JSON.parse(File.read f)
    end
  end

  def drop_collections collections
    db = Connection.db
    collections.each do |col|
      db[col].drop
    end
  end
end
