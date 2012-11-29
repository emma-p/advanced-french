['lib', File.dirname(__FILE__)].each { |path| $: << path }

require 'bundler'
Bundler.require

require 'active_support/all'
require 'connection'
require 'lesson'
require 'question'
require 'exercise'
require 'lesson_categories_fetcher'
require 'exercises_fetcher'
require 'exercise_presenter'
require 'lesson_category'
require 'user'
require 'user_answer_service'
require 'bouncer'
