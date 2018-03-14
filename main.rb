require_relative "lib/clothing_item"
require_relative "lib/wardrobe"

wardrobe = Wardrobe.load_from_data("#{__dir__}/data")

puts "Вас приветсвует Ваш гардероб!"
puts "Я помогу подобрать Вам одежду на сегодня. Какая сейчас температура за окном?"

user_input = STDIN.gets.to_i

items_set = wardrobe.choose_suitable_items(user_input)

puts "\nЗа окном #{user_input} градусов. Предлагаю Вам надеть:\n\r"

items_set.each do |item|
  puts item.present
end



