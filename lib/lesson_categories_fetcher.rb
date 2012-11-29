class LessonCategoriesFetcher
  
  def get_lesson_categories
    parsed_hash = Connection.db["lessons"].find.to_a
    grouped_hash = parsed_hash.group_by{ |cat| cat["category"] }
    results = grouped_hash.map do |lesson_category, lessons|
      LessonCategory.new lesson_category, lessons.map {|lesson| Lesson.new lesson["title"]}
    end
    results
  end

end
