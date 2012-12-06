['lib', File.dirname(__FILE__)].each { |path| $: << path }

require 'bundler'
Bundler.require

require 'active_support/all'
require 'connection'
require 'lesson'
require 'question'
require 'exercise'
require 'lessons_fetcher'
require 'exercises_fetcher'
require 'user'
require 'user_answer_service'
require 'bouncer'
