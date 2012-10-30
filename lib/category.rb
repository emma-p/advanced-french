class Category < Struct.new(:name, :lessons)
  def to_s
    "#{@name}: #{@lessons}"
  end
end
