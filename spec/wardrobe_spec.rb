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
      array = @wardrobe.choose_suitable_items(-10)

      array.each do |item|
        expect(item).to be_a(ClothingItem)
      end
    end

    it 'should return a nil due to bad argument type' do
      expect(@wardrobe.choose_suitable_items("a")).to eq nil
    end
  end

  describe '#make_a_set' do
    it 'should return Items Set (array of ClothigItem class Objects' do
      items = [
        ClothingItem.new(["Кепка", "Головной убор", "(-50,+50)"]),
        ClothingItem.new(["Кепка", "Торс", "(-50,+50)"]),
        ClothingItem.new(["Кепка", "Ступни", "(-50,+50)"]),
      ]
      item_set = @wardrobe.get_items(items)

      item_set.each do |item|
        expect(item).to be_a(ClothingItem)
      end
    end
  end
end