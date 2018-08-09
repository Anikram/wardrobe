# Clothing item class
class ClothingItem
  attr_reader :title, :category, :range

  def initialize(array)
    @title = array[0].chomp
    @category = array[1].chomp
    @range = to_range(array[2])
  end

  def to_s
    "#{title} (#{category}) #{range}"
  end

  def suits?(temperature)
    range.include?(temperature)
  end

  def to_range(string)
    array = string.gsub(/[()]+/, '').split
    Range.new(array[0].to_i, array[1].to_i)
  end
end
