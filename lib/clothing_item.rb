class ClothingItem
  attr_reader :title, :category, :range

  def initialize(array)
    @title = array[0].chomp
    @category = array[1].chomp
    @range = to_rage(array[2])
  end

  def present
    "#{title} (#{category}) #{range}"
  end

  def is_suit?(temperature)
    true if range.include?(temperature)
  end

  def to_rage(string)
    array = string.gsub(/[()]+/, "").split
    Range.new(array[0].to_i,array[1].to_i)
  end
end
