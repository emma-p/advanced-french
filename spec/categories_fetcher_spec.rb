#this spec tests the #get_categories method of the CategorieFetcher class. It makes sure the method can access data from a JSON file, use it to create Category and Lesson objects, and pass these on to Sinatra.

require 'categories_fetcher'
require 'spec_helper'

describe CategoriesFetcher do
  describe '#get_categories' do
    subject { CategoriesFetcher.new }
    it 'returns the list of lesson categories' do
      subject.lesson_file_path = 'spec/data/lessons_test.json'
      categories = subject.get_categories
      orth = categories.find { |cat| cat.name == 'Orthographe' }

      categories.map(&:name).should =~ ["Grammaire", "Orthographe"]
      orth.lessons.size.should == 1
      orth.lessons.first.title.should == 'Accents sur la lettre e'
    end
  end
end
