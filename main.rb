# Anikram 2018 - Ver.2
require_relative 'lib/clothing_item'
require_relative 'lib/wardrobe'

require 'byebug'

puts 'Вас приветсвует Ваш гардероб! (версия 2)'

wardrobe = Wardrobe.load_from_data("#{__dir__}/data")

puts 'Я помогу подобрать Вам одежду на сегодня.'

puts 'Какая сейчас температура за окном?'

begin
  wardrobe.choose_suitable_items(Integer(STDIN.gets))
rescue ArgumentError
  abort('Вы ввели не корректную температуру')
end

puts wardrobe.list_item_set
