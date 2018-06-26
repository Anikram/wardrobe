#Anikram 2018 - Ver.2
require_relative "lib/clothing_item"
require_relative "lib/wardrobe"

puts "Вас приветсвует Ваш гардероб! (версия 2)

wardrobe = Wardrobe.load_from_data("#{__dir__}/data")

wardrobe.get_user_input

wardrobe.list_item_set
