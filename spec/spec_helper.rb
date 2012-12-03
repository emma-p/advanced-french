#encoding:utf-8
ENV['RACK_ENV'] = 'test'
require 'rack/test'
require 'capybara/rspec'
require_relative '../advanced_french'

Capybara.app = AdvancedFrench

module SpecHelper
  TEST_LESSONS_FILE = 'spec/spec_data/lessons.json'
  TEST_EXERCISES_FOLDER = 'spec/spec_data/exercises/'

  def create_user_foo
    db = Connection.db
    salt = SecureRandom.base64
    secure_password = Digest::SHA2.hexdigest(salt + 'testpass')
    db["users"].insert({"email" => 'foo@bar.com', "salt" => salt, "password" => secure_password, "user_answers" => [ { "exercise_id" => 1, "answered_questions" => [1,2,4] }, { "exercise_id" => 2, "answered_questions" => [3,5,6] } ] })
  end

  def remove_user_foo
    db = Connection.db
    db["users"].drop
  end

  def load_lessons_and_exercises
    db = Connection.db

    db["lessons"].insert JSON.parse(File.read TEST_LESSONS_FILE)

    Dir.glob(TEST_EXERCISES_FOLDER + "**/*.json").each do |f|
      db["exercises"].insert JSON.parse(File.read f)
    end
  end

  def drop_all_collections
    db = Connection.db
    collections = ["lessons", "exercises"]
    collections.each do |col|
      db[col].drop
    end
  end
end
