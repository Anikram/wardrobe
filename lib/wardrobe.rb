class Wardrobe
  attr_accessor :all_items

  def self.load_from_data(path)
    wardrobe = []
    file_paths = Dir["#{path}/*"]

    file_paths.each do |path|
      wardrobe << ClothingItem.new(File.readlines(path))
    end

    self.new(wardrobe)
  end

  def initialize(array)
    @all_items = array
    @items_set = []
  end

  def choose_suitable_items(user_input)
    unless user_input.is_a?(Integer)
      puts "Вы ввели не корректную температуру"
      return
    end

    all_suitable_items = @all_items.select { |x| x.is_suit?(user_input) }
    @items_set = make_a_set(all_suitable_items)
  end

  def make_a_set(items)
    categories = read_all_categories(items)
    set_parts = {}

    categories.each do |category|
      set_parts[category] = sort_items_by_category(items, category)
    end

    items_set = combine_a_set(set_parts)
  end

  def read_all_categories(items)
    categories = []

    items.each do |item|
      categories << item.category if !categories.include?(item.category)
    end

    categories
  end

  def combine_a_set(set_parts)
    set = []
    set_parts.each_key { |key| set << set_parts[key].sample }
    set
  end

  def sort_items_by_category(items, category)
    good_items = items.select { |item| item.category == category}
  end
end
