ENV['RACK_ENV'] = 'test'
require 'rspec/autorun'
require 'rack/test'

module IntegrationHelper
  LESSONS_FILE_PATH = "data/lessons.json"

  def parse_lesson_file
    file = File.read LESSONS_FILE_PATH
    JSON.parse file
  end
end
