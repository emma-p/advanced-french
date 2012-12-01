class Lesson < Struct.new(:title, :category)
  def url
    "/lessons/#{title.parameterize}"
  end
end
