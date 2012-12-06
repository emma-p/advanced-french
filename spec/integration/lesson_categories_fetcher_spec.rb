#encoding:utf-8
require_relative '../spec_helper'

describe 'integration' do
  before do
    load_lessons_and_exercises
    create_user_foo
  end

  after do
    drop_all_collections
  end

  describe LessonsFetcher do
    subject { LessonsFetcher.new }

    describe '#get_lessons' do
      it 'returns the lessons from the db' do
        lessons = subject.get_lessons.map{|lesson| lesson.title}
        lessons.should =~ ["Adverbs", "Some rules about accents"]
      end
    end

    describe 'get_categories' do
      it 'returns the categories and the corresponding lessons from the db' do
        subject.get_categories.should =~ ["Grammar", "Spelling"]
      end
    end
  end
end
