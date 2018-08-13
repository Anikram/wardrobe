# Wardrobe class, which stores Clothing items instances
class Wardrobe
  attr_accessor :all_items, :error, :items_set, :user_temperature, :suitable_items

  # load items from file
  def self.load_from_data(address)
    item_number = 1
    wardrobe = []
    file_paths = Dir["#{address}/*"]

    file_paths.each do |path|
      wardrobe << ClothingItem.new(File.readlines(path) + item_number.to_s.split)
      item_number += 1
    end

    new(wardrobe)
  end

  def initialize(array)
    @all_items = array
    @suitable_items = nil
    @items_set = []
  end

  # generate items_set according to temperature input
  def choose_suitable_items(user_input)
    if user_input.is_a?(Integer)
      @suitable_items = items_by_temperature(user_input)

      set_parts = items_by_categories

      set_parts.each_key { |key| @items_set << set_parts[key].sample }


    else
      'Введена не корректная температура!'
    end
  end

  # choose all_items categories
  def categories
    categories = []

    items = @suitable_items || @all_items

    items.each do |item|
      categories << item.category unless categories.include?(item.category)
    end

    categories
  end

  # return items, separated by categories
  def items_by_categories
    set_parts = {}

    categories.each do |category|
      set_parts[category] = @suitable_items.select do |item|
        item.category == category
      end
    end

    set_parts
  end

  # return items, which suits for temperature
  def items_by_temperature(temperature)
    @all_items.select { |x| x.suits?(temperature) }
  end

  # show item list
  def list_item_set
    if !@items_set.flatten.any?
      responce = 'В вашем гардеробе нет '\
                  'вещей для такой погоды.'
    else
      responce = "\nЗа окном отличная погода."\
                  " Предлагаю Вам надеть:\n\r"
      @items_set.each do |item|
        responce << item.to_s + "\n"
      end
    end
    responce
  end
end
