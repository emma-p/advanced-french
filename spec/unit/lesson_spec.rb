#encoding:utf-8
require_relative '../spec_helper'

describe Lesson do
  describe '#url' do
    it 'returns a /lessons/lesson_title path where lesson_title is parameterized' do
      lesson_title = "Réviser ses conjonctions de coordination"
      lesson = Lesson.new lesson_title
      lesson.url.should == "/lessons/reviser-ses-conjonctions-de-coordination"
    end
  end
end
