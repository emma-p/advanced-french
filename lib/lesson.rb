class Lesson < Struct.new(:title)
  def url
    "/lessons/#{title.parameterize}"
  end
end
