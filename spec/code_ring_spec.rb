require './lib/code_ring'
require 'SimpleCOV'

RSpec.describe CodeRing do

  describe 'initialize' do
    it 'exists' do
      cr = CodeRing.new

      expect(cr).is_a?(CodeRing)
    end

    it 'has a date' do
      cr = CodeRing.new('40895', '010421')

      expect(cr.date).to eq('010421')
    end

    it 'has a character_set' do
      cr = CodeRing.new('40895', '010421')

      expect(cr.character_set.length).to eq(27)
      expect(cr.character_set[0]).to eq('a')
      expect(cr.character_set[-1]).to eq(' ')
    end

    it 'has a key' do
      cr = CodeRing.new('40895', '010421')

      expect(cr.key[0]).to eq('4')
    end

    it 'has an A shift' do
      cr = CodeRing.new('40895', '010421')

      expect(cr.a_shift).to be_an_instance_of(Integer)
    end

    it 'has a B shift' do
      cr = CodeRing.new('40895', '010421')

      expect(cr.b_shift).to be_an_instance_of(Integer)
    end

    it 'has a C shift' do
      cr = CodeRing.new('40895', '010421')

      expect(cr.c_shift).to be_an_instance_of(Integer)
    end

    it 'has a D shift' do
      cr = CodeRing.new('40895', '010421')

      expect(cr.d_shift).to be_an_instance_of(Integer)
    end
  end

  describe '#create_range' do
    it 'creates a range from 0 to 9' do
      cr = CodeRing.new('40895', '010421')

      expect(cr.create_range.length).to eq(10)
    end
  end

  describe '#select_randomly_from_range' do
    it 'randomly selects five numbers from range' do
      cr = CodeRing.new('40895', '010421')

      expect(cr.select_randomly_from_range.length).to eq(5)
    end
  end

  describe '#random_key_string' do
    it 'turns randomly selected key to a string' do
      cr = CodeRing.new('40895', '010421')

      expect(cr.random_key_string).is_a?(String)
    end
  end

  describe '#key_string_array_to_integer_array' do
    it 'converts key to array of strings' do
      cr = CodeRing.new('40895', '010421')

      expected = ['4', '0', '8', '9', '5']

      expect(cr.key_to_string_array).to eq(expected)
    end
  end

  describe '#key_string_array_to_integer_array' do
    it 'takes key string and turns it into an array of integers' do
      cr_1 = CodeRing.new('40895', '010421')

      expect(cr_1.key_string_array_to_integer_array).to eq([4, 0, 8, 9, 5])
    end
  end
end
