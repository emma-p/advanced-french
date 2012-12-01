class LessonsFetcher
  
  def get_lessons
    lessons = Connection.db["lessons"].find.to_a
    lessons.map{ |lesson| Lesson.new lesson["title"], lesson["category"] }
  end

  def get_categories
    categories = get_lessons.group_by{ |cat| cat["category"] }
    categories.map{ |category, lessons| category }
  end

end
