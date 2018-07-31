class Wardrobe
  attr_accessor :all_items, :errors, :items_set, :user_temperature

  #загрузка гардероба из файла
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
    @items_set = nil
    @user_temperature = nil
    @errors = nil
    @responce = nil
  end

  #приглашение на ввод температуры
  def get_user_input
    puts "Я помогу подобрать Вам одежду на сегодня."

    unless @user_temperature.is_a?(Integer)
      puts "Какая сейчас температура за окном?"
      @user_temperature = STDIN.gets.to_i
    end

    choose_suitable_items(@user_temperature)
  end


  #получить набор вещей, подходящих по температуре
  def choose_suitable_items(user_input)
    if user_input.is_a?(Integer)
      suitable_items = @all_items.select { |x| x.suits?(user_input) }
      @items_set = get_items_set(suitable_items)
    else
      @errors = "Введена не корректная температура! "
      nil
    end
  end

  #получить набо вещей
  def get_items_set(items)
    categories = get_categories(items)
    set_parts = {}

    categories.each do |category|
      set_parts[category] = sort_items_by_category(items, category)
    end

    generate_set(set_parts)
  end

  #определяет все категории, представленных в наборе вещей
  def get_categories(items)
    categories = []

    items.each do |item|
      categories << item.category unless categories.include?(item.category)
    end

    categories
  end

  #подбирает по одной случайной вещи из каждой категории
  def generate_set(set_parts)
    set = []
    set_parts.each_key { |key| set << set_parts[key].sample }
    set
  end

  #получить все вещи из набора, определенной категории
  def sort_items_by_category(items, category)
    items.select { |item| item.category == category}
  end

  #отобразить заранее собраный набор вещей
  def list_item_set
    return unless @items_set


    if @items_set.empty?
      @responce = 'В вашем гардеробе нет вещей для такой погоды.'
    else
      @responce = "\nЗа окном #{@user_temperature} градусов. Предлагаю Вам надеть:\n\r"

      @items_set.each do |item|
        @responce << item.to_s
      end
    end
    puts @responce
    @responce
  end
end
