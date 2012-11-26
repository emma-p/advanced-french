#encoding:utf-8
require_relative '../spec_helper'

describe 'integration' do
  before do
    load_lessons_exercises_and_users
  end

  after do
    drop_collections ["exercises", "lessons", "users"]
  end

  describe CategoriesFetcher do
    describe '#get_categories' do
      subject { CategoriesFetcher.new }

      it 'returns the lesson categories from the database' do
      categories = subject.get_categories 
      categories_names = categories.map {|category| category.name}
      categories_names.sort.should == ["Grammaire", "Orthographe", "Rédaction"] 
      end

      it 'returns the lessons corresponding to each category from the database' do
      categories = subject.get_categories 
      grammar_lessons = categories.find{|category| category.name == "Grammaire"}.lessons.map{|lesson| lesson.title}
      grammar_lessons.should == ["Adverbes", "Conditionnel"]
      end
    end
  end
end
