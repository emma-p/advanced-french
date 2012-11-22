['lib', File.dirname(__FILE__)].each { |path| $: << path }

require 'bundler'
Bundler.require

require 'active_support/all'
require 'connection'
require 'lesson'
require 'question'
require 'exercise'
require 'categories_fetcher'
require 'exercises_fetcher'
require 'views/helpers/exercise_helper'
require 'category'
require 'user'
require 'rack/test'
require 'user_data_fetcher'
require 'bouncer'
