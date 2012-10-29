require_relative 'parser_module.rb'
require_relative '../category.rb'
require_relative '../lesson.rb'

#CategoriesFetcher is a class which only goal is to get a list of the categories from the Lessons JSON file and give them to Sinatra.

class CategoriesFetcher
  include Parser
  LESSONS_FILE_PATH = "data/lessons.json"
  
  def get_categories
    parsed_hash = parse_json_file lesson_file_path
    grouped_hash = parsed_hash.group_by{ |cat| cat["category"] }
    results = grouped_hash.map do |category, lessons|
      Category.new category, lessons.map {|lesson| Lesson.new lesson["title"]}
    end
    results
  end

  def lesson_file_path= path
    @lesson_file_path = path
  end

  def lesson_file_path
    @lesson_file_path || LESSONS_FILE_PATH
  end
end
