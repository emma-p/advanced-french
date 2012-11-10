require_relative 'parser_module.rb'
require_relative 'category.rb'
require_relative 'lesson.rb'

#CategoriesFetcher is a class which only goal is to get a list of the categories from the DB and give them to Sinatra.

class CategoriesFetcher
  
  def get_categories
    db = Mongo::Connection.new.db "learning_platform_db"
    parsed_hash = db["lessons"].find.to_a
    grouped_hash = parsed_hash.group_by{ |cat| cat["category"] }
    results = grouped_hash.map do |category, lessons|
      Category.new category, lessons.map {|lesson| Lesson.new lesson["title"]}
    end
    results
  end
end
