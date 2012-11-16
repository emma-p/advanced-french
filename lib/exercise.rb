class Exercise < Struct.new(:title, :questions)
  def name
    title.parameterize
  end

  def url
    "/exercises/#{name}"
  end

end
