require 'rspec'
require_relative '../lib/clothing_item'

describe "Clothing Item Object" do

  before :each do
    @item = ClothingItem.new(["Шапка", "Головной убор", "(-15, 0)"])
  end

  describe 'initialization' do
    describe '#new' do
      it 'should return an Object of ClothingItem Class' do
        expect(@item).to be_a(ClothingItem)
      end
    end

    describe '#to_range' do
      it 'should convert a String into a Range Object' do
        expect(@item.to_range("-10, 20")).to eq(-10..20)
      end
    end
  end

  describe '#present' do
    it 'should return a parsed String' do
      expect(@item.to_s).to eq("Шапка (Головной убор) -15..0")
    end
  end

  describe 'temperatures checks' do
    describe '#suits?' do
      it 'should return TrueClass Object' do
        expect(@item.suits?(-10)).to be_a(TrueClass)
      end

      it 'should return FalseClass Object' do
        expect(@item.suits?(10)).to be_a(FalseClass)
      end
    end
  end
end