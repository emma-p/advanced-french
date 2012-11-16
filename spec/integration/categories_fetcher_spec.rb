#this spec tests the #get_categories method of the CategorieFetcher class. It makes sure the method can access data from the database, use it to create Category and Lesson objects, and pass these on to Sinatra.
require_relative '../spec_helper'

describe CategoriesFetcher do
  describe '#get_categories' do
    subject { CategoriesFetcher.new }
    it 'returns the list of lesson categories' do
    end
  end
end
