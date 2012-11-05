require_relative 'question.rb'
require_relative 'parser_module.rb'

class Exercise < Struct.new(:title, :questions)
  include Parser

  def url
    "/exercises/#{name}"
  end

  def name
    title.parameterize
  end

end

