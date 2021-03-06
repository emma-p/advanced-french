#encoding:utf-8
require_relative 'spec_helper'

include SpecHelper

describe 'end to end', :type => :feature do

  before do
    load_lessons_and_exercises
    create_user_foo
  end

  after do
    drop_all_collections
    remove_user_foo
  end

  describe 'home page' do
    it 'loads the index' do
      visit '/'
      page.should have_css("img", :count => 2)
    end
  end

  describe 'lessons page' do
    it 'displays all the lessons' do
      visit '/lessons'
      page.should have_text "Adverbs" #title
      page.should have_text "Grammar" #category
    end
  end

  describe 'lesson page' do
    it 'displays the specific lesson required in the lessons page' do
      visit "/lessons/adverbs"
      page.should have_text "Qu'est-ce qu'un adverbe de manière?"
    end
  end

  describe 'exercises page' do
    it 'displays all the exercises available in the exercises folder' do
      visit '/exercises'
      page.should have_text "Conditionnel ou indicatif?"
    end
  end

  describe 'exercise page for unknown user' do
    before do
      visit "/exercises/1"
    end

    it 'displays the specific exercise required in the exercises page' do
      page.should have_text "Conditionnel ou indicatif?"
      page.should have_text "Marianne a affirmé qu'elle viendrait"
    end

    it 'returns an empty question box and x icon when the user gives a wrong answer' do
      fill_in 'answer_3', :with => 'fours'
      click_button 'Submit'
      page.should have_no_text 'Vous verrez si vous pouvez assister'
      page.should have_css('i.icon-remove', :count => 1)
    end

    it 'returns the answer when the user gives a right answer' do
      fill_in 'answer_10', :with => 'pourra'
      click_button 'Submit'
      page.should have_text "Nous serons tous soulagés lorsqu'il pourra"
      page.should have_css('i.icon-ok', :count => 1)
    end
  end

  describe 'exercise page for logged in user' do
    before do
      visit '/login'
      fill_in 'email', :with => 'foo@bar.com'
      fill_in 'password', :with => 'testpass'
      click_button 'Login'
      visit "/exercises/1"
    end

    it 'displays the specific exercise required in the exercises page' do
      page.should have_text "Conditionnel ou indicatif?"
      page.should have_text "Marianne a affirmé qu'elle viendrait"
    end

    it 'returns an empty question box and x icon when the user gives a wrong answer' do
      #real answer : verrez
      fill_in 'answer_3', :with => 'fours'
      click_button 'Submit'
      page.should have_no_text 'Vous verrez si vous pouvez assister'
      page.should have_css('i.icon-remove', :count => 1)
    end

    it 'returns the answer when the user gives a right answer', current: true do
      fill_in 'answer_10', :with => 'pourra'
      click_button 'Submit'
      page.should have_text "Nous serons tous soulagés lorsqu'il pourra"
      page.should have_css('i.icon-ok', :count => 4)
    end

    it 'displays the questions already answered by a logged in user' do
      page.should have_text "aurait fini"
      page.should have_text "aurais"
      page.should have_text "souhaiterais"
    end

    it 'saves correct answers in the db for logged in users' do
      fill_in 'answer_9', :with => 'étaient'
      fill_in 'answer_10', :with => 'pourra'
      click_button 'Submit'
      user_answer_service = UserAnswerService.new 'foo@bar.com'
      exercise = ExercisesFetcher.new.find_exercise '1'
      user_answer_service.get_user_answers_for(exercise).should == [1,2,4,9,10]
    end
  end

  describe 'authentication with good credentials' do
    before do
      visit '/login'
      fill_in 'email', :with => 'foo@bar.com'
      fill_in 'password', :with => 'testpass'
      click_button 'Login'
    end

    it 'allows a signed up user to login' do
      page.should have_text "Logged in as foo@bar.com"
      page.should have_link "Sign out"
    end

    it 'does not allow a signed up user to try to login again' do
      visit '/login'
      page.should have_css("img", :count => 2) #redirects to index page
    end

    it 'allows a logged in user to sign out' do
      visit '/signout'
      page.should_not have_text "Logged in as foo@bar.com"
      page.should have_text "Login"
    end
  end

  describe 'authentication with bad credentials' do
    it 'does not allow a non signed up user to login' do
      visit '/login'
      fill_in 'email', :with => 'four@bar.com'
      fill_in 'password', :with => 'pass'
      click_button 'Login'
      page.should have_text "Wrong email or password"
      page.should have_button "Login"
    end
  end

end
