class Exercise < Struct.new(:id, :title, :questions)
  def name
    title.parameterize
  end

  def url
    "/exercises/#{name}"
  end

end
