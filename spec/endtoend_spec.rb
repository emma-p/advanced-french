#encoding:utf-8
require_relative 'spec_helper'

include SpecHelper

def app
  LearningPlatform
end

describe 'end to end', :type => :feature do

  before do
    load_lessons_exercises_and_users
  end

  after do
    drop_collections ["exercises", "lessons", "users"]
  end

  describe 'home page' do
    it 'loads the index' do
      visit '/'
    end
  end

  describe 'lessons page' do
    it 'displays all the lessons' do
      visit '/lessons'
      page.should have_text "Adverbes" #title
      page.should have_text "Grammaire" #category
    end
  end

  describe 'lesson page' do
    it 'displays the specific lesson required in the lessons page' do
      visit "/lessons/adverbes"
      page.should have_text "Adverbes"
    end
  end

  describe 'exercises page' do
    it 'displays all the exercises available in the exercises folder' do
      visit '/exercises'
      page.should have_text "Conditionnel ou indicatif?"
    end
  end

  describe 'exercise page' do
    it 'displays the specific exercise required in the exercises page' do
      visit "/exercises/conditionnel-ou-indicatif"
      page.should have_text "Conditionnel ou indicatif?"
      page.should have_text "Marianne a affirmé qu'elle viendrait"
    end

    it 'displays the questions already answered by a logged in user' do
      visit '/login'
      fill_in 'email', :with => 'foo@bar.com' 
      fill_in 'password', :with => 'pass' 
      click_button 'Login'
      visit "/exercises/conditionnel-ou-indicatif"
      page.should have_text "aurait fini"
      page.should have_text "aurais"
      page.should have_text "souhaiterais"
    end

    it 'returns an empty question box and x icon when the user gives a wrong answer' do
      visit "/exercises/conditionnel-ou-indicatif"
      fill_in 'attempt_3', :with => 'fours'
      click_button 'Submit'
      page.should have_no_text 'Vous verrez si vous pourrez assister'
      page.should have_css('i.icon-remove', :count => 1)
    end

    it 'returns the answer when the user gives a right answer' do
      visit "/exercises/conditionnel-ou-indicatif"
      fill_in 'attempt_10', :with => 'pourra'
      click_button 'Submit'
      page.should have_text "Nous serons tous soulagés lorsqu'il pourra" 
      page.should have_css('i.icon-ok', :count => 1)
    end
  end

  describe 'login' do
    it 'allows a signed up user to login' do
      visit '/login'
      fill_in 'email', :with => 'foo@bar.com' 
      fill_in 'password', :with => 'pass' 
      click_button 'Login'
      page.should have_text "Logged in as foo@bar.com"
      page.should have_link "Sign out"
    end

    it 'does not allow a non signed up user to login' do
      visit '/login'
      fill_in 'email', :with => 'four@bar.com' 
      fill_in 'password', :with => 'pass' 
      click_button 'Login'
      page.should have_text "Wrong email or password"
      page.should have_text "Login"
    end

    it 'does not allow a signed up user to try to login again' do
      visit '/login'
      fill_in 'email', :with => 'foo@bar.com' 
      fill_in 'password', :with => 'pass' 
      click_button 'Login'
      visit '/login'
      page.should have_text "Browse our lessons with topics"
    end
  end

  describe 'signout' do
    it 'disconnects a logged in user' do
      visit '/login'
      fill_in 'email', :with => 'foo@bar.com' 
      fill_in 'password', :with => 'pass' 
      click_button 'Login'
      visit '/signout'
      page.should_not have_text "Logged in as foo@bar.com"
      page.should have_text "Login"
    end
  end
end
