require_relative '../../lesson.rb'

describe Lesson do
  describe '::get_lessons_from_files' do
    it 'loads the lessons from the JSON file' do
      lessons = Lesson.get_lessons_from_files
      lessons.size.should be > 0
      lesson = lessons[0]
      lesson.class.should be Lesson
      lessons.map(&:title).should include Lesson.parse_lesson_file.sample["title"]
    end
  end
end
