require './lib/code_ring'

RSpec.describe CodeRing do

  describe 'initialize' do
    it 'exists' do
      code_ring = CodeRing.new('this', '12345', '040895')

      expect(code_ring).is_a?(CodeRing)
    end

    it 'has a phrase' do
      code_ring = CodeRing.new('this', '12345', '040895')

      expect(code_ring.phrase).to eq('this')
    end

    it 'has a key' do
      code_ring = CodeRing.new('this', '12345', '040895')

      expect(code_ring.key).to eq('12345')
    end

    it 'has a date' do
      code_ring = CodeRing.new('this', '12345', '040895')

      expect(code_ring.date).to eq('040895')
    end

    it 'has a character set' do
      code_ring = CodeRing.new('this', '12345', '040895')

      expect(code_ring.character_set.length).to eq(27)
    end
  end

  describe '#key_to_string_array' do
    it 'transforms key string to an array' do
      code_ring = CodeRing.new('this', '12345', '040895')

      expected = ['1', '2', '3', '4', '5']

      expect(code_ring.key_to_string_array).to eq(expected)
    end
  end

  describe '#key_string_array_to_integer_array' do
    it 'tranforms string array into an integer array' do
      code_ring = CodeRing.new('this', '12345', '040895')

      expected = [1, 2, 3, 4, 5]

      expect(code_ring.key_string_array_to_integer_array).to eq(expected)
    end
  end

  describe '#key_pairs' do
    it 'returns an array of key pairs' do
      code_ring = CodeRing.new('this', '12345', '040895')

      expected = [[1, 2], [2, 3], [3, 4], [4, 5]]

      expect(code_ring.key_pairs).to eq(expected)
    end
  end

  describe '#key_pairs_integers' do
    it 'combines the integer pairs' do
      code_ring = CodeRing.new('this', '12345', '040895')

      expected = [12, 23, 34, 45]

      expect(code_ring.key_pairs_integers).to eq(expected)
    end
  end

  describe '#date_to_integer' do
    it 'transforms date string to integer' do
      code_ring = CodeRing.new('this', '12345', '040895')

      expect(code_ring.date_to_integer).to eq(40895)
    end
  end

  describe '#square_date' do
    it 'squares the date integer' do
      code_ring = CodeRing.new('this', '12345', '040895')

      expect(code_ring.square_date).to eq(1672401025)
    end
  end

  describe '#squared_date_to_string' do
    it 'returns the squared date integer as a string' do
      code_ring = CodeRing.new('this', '12345', '040895')

      expect(code_ring.squared_date_to_string).to eq('1672401025')
    end
  end

  describe '#string_date_last_four' do
    it 'gives the last four numbers of squared the date in an array' do
      code_ring = CodeRing.new('this', '12345', '040895')

      expect(code_ring.string_date_last_four).to eq(['1', '0', '2', '5'])
    end
  end

  describe '#date_transformation' do
    it 'transforms last four of date to an integer' do
      code_ring = CodeRing.new('this', '12345', '040895')

      expect(code_ring.date_transformation).to eq([1, 0, 2, 5])
    end
  end

  describe '#a_shift' do
    it 'gives the amount the a position letters will be shifted' do
      code_ring = CodeRing.new('this', '12345', '040895')

      expect(code_ring.a_shift).to eq(13)
    end
  end

  describe '#b_shift' do
    it 'gives the amount the b position letters will be shifted' do
      code_ring = CodeRing.new('this', '12345', '040895')

      expect(code_ring.b_shift).to eq(23)
    end
  end

  describe '#c_shift' do
    it 'gives the amount the c position letters will be shifted' do
      code_ring = CodeRing.new('this', '12345', '040895')

      expect(code_ring.c_shift).to eq(36)
    end
  end

  describe '#d_shift' do
    it 'gives the amount the d position letters will be shifted' do
      code_ring = CodeRing.new('this', '12345', '040895')

      expect(code_ring.d_shift).to eq(50)
    end
  end

  describe '#phrase_array' do
    it 'gives the phrase as an array' do
      code_ring = CodeRing.new('this', '12345', '040895')

      expect(code_ring.phrase_array).to eq(['t', 'h', 'i', 's'])
    end
  end

  describe '#phrase_sets_of_four' do
    it 'breaks the phrase array into sets of four' do
      code_ring = CodeRing.new('this old thing', '12345', '040895')

      expected = [['t', 'h', 'i', 's'], [' ', 'o', 'l', 'd'], [' ', 't', 'h', 'i'], ['n', 'g']]

      expect(code_ring.phrase_sets_of_four).to eq(expected)
    end
  end

  describe '#not_nil?' do
    it 'returns nil if given index does not exist' do
      code_ring = CodeRing.new('this', '12345', '040895')
      sample_array = ['a', 'b', 'c']

      expect(code_ring.not_nil?(sample_array, 0)).to eq(true)
      expect(code_ring.not_nil?(sample_array, 7)).to eq(false)
    end
  end

  describe '#included_in_char_set' do
    it 'returns true if given character is included in the character set' do
      code_ring = CodeRing.new('this', '12345', '040895')
      sample_array = ['a', 'b', 'c', '@']

      expect(code_ring.included_in_char_set?(sample_array, 0)).to eq(true)
      expect(code_ring.included_in_char_set?(sample_array, -1)).to eq(false)
    end
  end

  describe '#not_nil_and_included' do
    it 'returns true if given index is not nil and the character is included in character set' do
      code_ring = CodeRing.new('this', '12345', '040895')
      sample_array = ['a', 'b', 'c', '@']

      expect(code_ring.not_nil_and_included?(sample_array, 0)).to eq(true)
      expect(code_ring.not_nil_and_included?(sample_array, -1)).to eq(false)
    end
  end

  describe '#not_nil_not_included' do
    it 'returns true if array index is not nil and the character is not included in character set' do
      code_ring = CodeRing.new('this', '12345', '040895')
      sample_array = ['a', 'b', 'c', '@']

      expect(code_ring.not_nil_not_included?(sample_array, 0)).to eq(false)
      expect(code_ring.not_nil_not_included?(sample_array, -1)).to eq(true)
    end
  end
end
