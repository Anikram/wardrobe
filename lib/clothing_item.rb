class ClothingItem
  attr_reader :title, :category, :range

  def initialize(array)
    @title = array[0].chomp
    @category = array[1].chomp
    @range = to_range(array[2])
  end

  def present
    "#{title} (#{category}) #{range}"
  end

  def is_suit?(temperature)
    range.include?(temperature) ? true : false
  end

  def to_range(string)
    array = string.gsub(/[()]+/, "").split
    Range.new(array[0].to_i,array[1].to_i)
  end
end
