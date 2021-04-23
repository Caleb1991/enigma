require './lib/key'

RSpec.describe Key do

  describe 'initialize' do
    it 'exists' do
      key = Key.new('040895')

      expect(key).is_a?(Key)
    end

    it 'has a range from a-z plus a space' do
      key = Key.new('040895')

      expect(key.alphabet.length).to eq(27)
    end

    it 'has a date' do
      key = Key.new('040895')

      expect(key.date).to eq('040895')
    end

    it 'generates a random five digit number' do
      key = Key.new('040895')

      expect(key.random_number.length).to eq(5)
    end

    it 'has an A shift' do
      key = Key.new('040895')

      expect(key.a_shift).to be_an_instance_of(Integer)
    end

    it 'has a B shift' do
      key = Key.new('040895')

      expect(key.b_shift).to be_an_instance_of(Integer)
    end

    it 'has a C shift' do
      key = Key.new('040895')

      expect(key.c_shift).to be_an_instance_of(Integer)
    end

    it 'has a D shift' do
      key = Key.new('040895')

      expect(key.d_shift).to be_an_instance_of(Integer)
    end

    it 'starts with no phrase' do
      key = Key.new('040895')

      expect(key.phrase).to eq(nil)
    end
  end

  describe '#shift' do
    it 'creates consecutive pairs of randomly generated number' do
      key = Key.new('040895')

      expect(key.shift.length).to eq(4)
    end
  end

  describe '#date_transformation' do
    it 'transforms date to integer' do
      key = Key.new('040895')

      expect(key.date_transformation).to eq(1025)
    end
  end

  describe '#take_in_phrase' do
    it 'takes in a phrase' do
      key = Key.new('040895')

      key.take_in_phrase('We gotta give Han more time')

      expect(key.phrase).to eq('we gotta give han more time')
    end
  end
end
