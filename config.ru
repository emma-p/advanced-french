require "bundler"
require "sinatra"
require "active_support/core_ext"
require "i18n"
require "json"
require "pry"
require "mongo"
require "haml"

Bundler.require

require "./learning_platform"
run LearningPlatform
