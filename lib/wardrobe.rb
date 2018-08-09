# Wardrobe class, which stores Clothing items instances
class Wardrobe
  attr_accessor :all_items, :error, :items_set, :user_temperature

  # load items from file
  def self.load_from_data(address)
    wardrobe = []
    file_paths = Dir["#{address}/*"]

    file_paths.each do |path|
      wardrobe << ClothingItem.new(File.readlines(path))
    end

    new(wardrobe)
  end

  def initialize(array)
    @all_items = array
    @suitable_items = nil
    @items_set = []
    @user_temperature = nil
    @error = nil
    @responce = nil
  end

  # generate items_set according to temperature input
  def choose_suitable_items(user_input)
    if user_input.is_a?(Integer)
      @user_temperature = user_input

      @suitable_items = items_by_temperature(@user_temperature)

      set_parts = items_by_categories

      set_parts.each_key { |key| @items_set << set_parts[key].sample }
    else
      @error = 'Введена не корректная температура!'
    end
  end

  # choose all_items categories
  def categories
    categories = []

    @suitable_items.each do |item|
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
    if @items_set.empty?
      @responce = 'В вашем гардеробе нет '\
                  'вещей для такой погоды.'
    else
      @responce = "\nЗа окном #{@user_temperature} градусов."\
                  " Предлагаю Вам надеть:\n\r"
      @items_set.each do |item|
        @responce << item.to_s + "\n"
      end
    end
    @responce
  end
end
