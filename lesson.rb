require 'json'

class Lesson
  LESSONS_FILE_PATH = "data/lessons.json"
  attr_reader :title, :category

  def initialize title, category
    @title = title
    @category = category
  end

  def self.get_lessons_from_files
    parse_lesson_file.map do |lesson_hash|
      Lesson.new lesson_hash["title"], lesson_hash["category"]
    end
  end

  def self.parse_lesson_file
    file = File.read LESSONS_FILE_PATH
    JSON.parse file
  end

end
