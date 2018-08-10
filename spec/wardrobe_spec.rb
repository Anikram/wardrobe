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

  describe '.load_from_data' do
    context 'reads files from a folder' do
      it 'create an array of ClothingItem instances' do
        wardrobe = Wardrobe.load_from_data(path)

        expect(wardrobe.all_items.class).to be(Array)
        wardrobe.all_items.each do |item|
          expect(item.class).to be(ClothingItem)
        end
      end
    end
  end

  describe '#categories' do
    it 'retuns the array of strings (category names)' do
      @wardrobe.choose_suitable_items(10)
      expect(@wardrobe.categories).to eq(['Ступни', 'Голова', 'Торс'])
    end

    it 'returns an empty array, when no suitable items categories exists' do
      @wardrobe.choose_suitable_items(100)
      expect(@wardrobe.categories).to eq([])
    end
  end

  describe '#items_by_categories' do
    it 'retuns the hash of items(category1: [item1, item2], cate... )' do
      @wardrobe.choose_suitable_items(10)
      hash = @wardrobe.items_by_categories
      expect(hash.keys).to eq(["Ступни", "Голова", "Торс"])
      expect(hash.values.sample.first.title).to eq('Кепка')
    end
  end

  describe '#items_by_temperature' do
    context 'when there are some items for the temperature' do
      it 'returns items which are good for temperature' do
        items = @wardrobe.items_by_temperature(10)

        items.each do |item|
          range = item.range
          expect(range).to cover(10)
        end
      end
    end

    context 'when no items for the temperature' do
      it 'returns an empty array' do
        items = @wardrobe.items_by_temperature(100)
        expect(items).to eq([])
      end
    end
  end
end
