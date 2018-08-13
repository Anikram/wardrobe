require 'rspec'
require_relative '../lib/wardrobe.rb'
require_relative '../lib/clothing_item'

describe 'Wardrobe Class Object' do
  path = "#{__dir__}/fixtures"

  before :each do
    @wardrobe = Wardrobe.load_from_data(path)
  end

  describe '#load_from_data' do
    context 'reads files from a folder' do
      it 'returns Wardrobe Class Object' do
        expect(Wardrobe.load_from_data(path)).to be_a(Wardrobe)
      end

      it 'creates an array of ClothingItem instances' do
        wardrobe = Wardrobe.load_from_data(path)

        expect(wardrobe.all_items.class).to be(Array)

        n = 1

        wardrobe.all_items.each do |item|
          expect(item.class).to be(ClothingItem)
          expect(item.id).to eq n
          n += 1
        end
      end

      it 'first ClothingItem of an array is legal' do
        item = @wardrobe.all_items.sort_by(&:id).min
        expect(item.id).to eq 1
        expect(item).to be_a ClothingItem
        expect(item.title).to eq 'Кепка'
        expect(item.to_s).to eq('Кепка (Голова) -50..50')
      end
    end
  end

  describe '#choose_suitable_items' do
    it 'returns an Array of ClothingItem Class Objects' do
      @wardrobe.choose_suitable_items(-10)
      array = @wardrobe.items_set

      array.each do |item|
        expect(item).to be_a(ClothingItem)
        expect(item.suits?(-10)).to be_truthy
      end
    end

    it 'returns error message if temperature is not correct' do
      responce = @wardrobe.choose_suitable_items('a')
      expect(responce).to eq('Введена не корректная температура!')
    end

    it 'returns three ClothingItem instances' do
      @wardrobe.choose_suitable_items(10)
      array = @wardrobe.suitable_items
      expect(array.length).to eq 3
    end
  end
  describe '#get_items_set' do
    it 'returns Items Set ' do
      @wardrobe.choose_suitable_items(40)
      expect(@wardrobe.items_set).to be_a(Array)

      expect(@wardrobe.list_item_set).to eq "\nЗа окном отличная погода."\
                                   " Предлагаю Вам надеть:\n\rКепка (Голова) "\
                                   "-50..50\nКепка (Ступни) -50..50\nКепка "\
                                   "(Торс) -50..50\n"
    end

    it 'returns message when no items suits' do
      @wardrobe.choose_suitable_items(90)
      expect(@wardrobe.items_set).to be_a(Array)

      expect(@wardrobe.list_item_set).to eq 'В вашем гардеробе '/
                                        'нет вещей для такой погоды.'
    end
  end

  describe '#categories' do
    it 'returns the array of strings (category names)' do
      @wardrobe.choose_suitable_items(10)
      expect(@wardrobe.categories).to eq %w[Голова Ступни Торс]
    end

    it 'returns an empty array, when no suitable items categories exists' do
      @wardrobe.choose_suitable_items(100)
      expect(@wardrobe.categories).to eq([])
    end

    it 'returns all available categories when called just after IDLE state' do
      expect(@wardrobe.categories).to eq %w[Голова Ступни Торс]
    end
  end

  describe '#items_by_categories' do
    it 'returns the hash of items(category1: [item1, item2], cate... )' do
      @wardrobe.choose_suitable_items(10)
      hash = @wardrobe.items_by_categories
      expect(hash.keys).to eq %w[Голова Ступни Торс]
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
