class CategoriesFetcher
  
  def get_categories
    parsed_hash = Connection.db["lessons"].find.to_a
    grouped_hash = parsed_hash.group_by{ |cat| cat["category"] }
    results = grouped_hash.map do |category, lessons|
      Category.new category, lessons.map {|lesson| Lesson.new lesson["title"]}
    end
    results
  end

end
