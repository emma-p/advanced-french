require_relative 'question.rb'

class Exercise < Struct.new(:title, :questions)

  def url
    "/exercises/#{name}"
  end

  def name
    title.parameterize
  end

end

