ENV['RACK_ENV'] = 'test'
require_relative '../learning_platform'

module SpecHelper
  def parse_json_file file
    JSON.parse File.read file
  end
end
