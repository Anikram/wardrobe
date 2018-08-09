require 'rspec'
require_relative '../lib/wardrobe.rb'
require_relative '../lib/clothing_item'

describe 'Wardrobe Class Object' do
  path = "#{__dir__}/fixtures"

  before :each do
    @wardrobe = Wardrobe.load_from_data(path)
  end

  describe '#load_from_data' do
    it 'should return Wardrobe Class Object' do
      expect(Wardrobe.load_from_data(path)).to be_a(Wardrobe)
    end
  end

  describe '#choose_suitable_items' do
    it 'should return an Array of ClothingItem Class Objects' do
      @wardrobe.choose_suitable_items(-10)
      array = @wardrobe.items_set

      array.each do |item|
        expect(item).to be_a(ClothingItem)
        expect(item.suits?(-10)).to be_truthy
      end
    end

    it 'should return error message if tempreture is not correct' do
      @wardrobe.choose_suitable_items('a')

      expect(@wardrobe.error).to eq('Введена не корректная температура!')
    end
  end
  describe '#get_items_set' do
    it 'should return Items Set ' do
      @wardrobe.choose_suitable_items(90)
      expect(@wardrobe.items_set).to be_a(Array)

      @wardrobe.items_set.each do |item|
        expect(item).to be_a(ClothingItem)
      end

      expect(@wardrobe.list_item_set).to eq 'В вашем гардеробе нет вещей для такой погоды.'
    end
  end
end
