# rspec file to test the Game class

require_relative '../lib/game.rb'

describe Game do
  describe '#valid_response?' do
    subject(:valid_game) {described_class.new}
    it 'returns false when passed a word' do
      validity = valid_game.valid_response?('taco')
      expect(validity).to be(false)
    end
    it 'returns false when there is no comma' do
      validity = valid_game.valid_response?('1 2')
      expect(validity).to be(false)
    end
    it 'returns false when the numbers are too high' do
      validity = valid_game.valid_response?('1, 16')
      expect(validity).to be(false)
    end
    it 'returns false when the numbers are too low' do
      validity = valid_game.valid_response?('0, 8')
      expect(validity).to be(false)
    end
    it 'returns true when passed a valid coordinate' do
      validity = valid_game.valid_response?('1, 2')
      expect(validity).to be(false)
    end
  end

  describe '#convert_to_coordinates' do
    subject(:convert_game) {described_class.new}
    it 'changes a string to an array with coordinates' do
      coordinates = convert_game.convert_to_coordinates('1, 2')
      expect(coordinates).to eq([1, 2])
    end
  end
end


  
  