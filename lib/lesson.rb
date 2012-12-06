class Lesson
  attr_reader :title, :category

  def initialize title, category
    @title = title
    @category = category
  end

  def url
    "/lessons/#{title.parameterize}"
  end
end
