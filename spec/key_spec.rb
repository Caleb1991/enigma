require './lib/key'
require 'SimpleCOV'

RSpec.describe Key do

  describe 'initialize' do
    it 'exists' do
      key = Key.new('040895')

      expect(key).is_a?(Key)
    end

    it 'has a date' do
      key = Key.new('040895')

      expect(key.date).to eq('040895')
    end

    it 'has a character_set' do
      key = Key.new('040895')

      expect(key.character_set.length).to eq(27)
      expect(key.character_set[0]).to eq('a')
      expect(key.character_set[-1]).to eq(' ')
    end

    it 'has a range' do
      key = Key.new('040895')

      expect(key.range[0]).to eq(1)
      expect(key.range[-1]).to eq(9)
    end

    it 'generates a random number lead by zero' do
      key = Key.new('040895')

      # require 'pry'; binding.pry

      expect(key.random_number[0]).to eq('0')
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

  describe '#random_number_generator' do
    it 'generates a random four digit number' do
      key = Key.new('040895')

      random_number = key.random_number_generator

      expect(random_number).is_a?(Integer)
      expect(random_number.length).to eq(4)
    end
  end

  describe '#add_zero_to_random_number' do
    it 'adds a zero to the front of a randomly generated number' do
      key = Key.new('040895')

      add_zero = key.add_zero_to_random_number

      expect(add_zero[0]).to eq(0)
      expect(add_zero.length).to eq(5)
    end
  end

  describe 'random_number_join' do
    it 'removes the random number from an array' do
      key = Key.new('040895')

      join = key.random_number_join

      expect(join).is_a?(String)
      expect(join.class).not_to eq(Array)
    end
  end

  describe '#random_number_pairs' do
    it 'breaks random number into four pairs' do
      key = Key.new('040895')

      pairs = key.random_number_pairs

      expect(pairs.length).to eq(4)
    end
  end

  describe '#random_number_pairs' do
    it 'sums each set of pairs individually' do
      key = Key.new('040895')

      expect(key.random_number_pairs_sums.length).to eq(4)
    end
  end

  describe '#date_to_integer' do
    it 'transforms date string to an integer' do
      key = Key.new('040895')

      integer = key.date_to_integer

      expect(integer).to eq(40895)
    end
  end

  describe '#square_date' do
    it 'squares the given date' do
      key = Key.new('040895')

      square = key.square_date

      expect(square).to eq(1672401025)
    end
  end

  describe '#squared_date_to_string' do
    it 'returns the squared date back to a string' do
      key = Key.new('040895')

      string = key.squared_date_to_string

      expect(string).to eq('1672401025')
    end
  end

  describe '#string_date_sample' do
    it 'takes the last four digits of the squared date string' do
      key = Key.new('040895')

      sample = key.string_date_sample

      expect(sample).to eq('1025')
    end
  end

  describe '#date_transformation' do
    it 'transforms date to integer' do
      key = Key.new('040895')

      expect(key.date_transformation).to eq(1025)
    end
  end

  describe '#take_in_phrase' do
    it 'takes in a phrase and downcases it' do
      key = Key.new('040895')

      key.take_in_phrase('We gotta give Han more time')

      expect(key.phrase).to eq('we gotta give han more time')
    end
  end

  describe '#phrase_array' do
    it 'breaks phrase into single characters in an array' do
      key = Key.new('040895')

      key.take_in_phrase('HeLlO')

      array = key.phrase_array

      expect(array).to eq(['h', 'e', 'l', 'l', 'o'])
    end
  end

  describe '#phrase_sets_of_four' do
    it 'breaks phrase array into single characters' do
      key = Key.new('040895')

      key.take_in_phrase('HeLlO')

      array = key.phrase_sets_of_four

      expect(array).is_a?(Array)
    end
  end

  describe '#encode_first_index' do
    it 'finds given letter or space in character set and gives its index value' do
      key = Key.new('040895')
      sample_array = ['a', 'f', 'g', 'd']

      first_index = key.encode_first_index(sample_array, 2)

      expect(first_index).to eq(6)
    end
  end

  describe '#encode_first_rotation' do
    it 'rotates character array so that the given letter is in the zero position' do
      key = Key.new('040895')
      sample_array = ['a', 'f', 'g', 'd']

      first_rotation = key.encode_first_rotation(sample_array, 2)

      expect(first_rotation[0]).to eq('g')
    end
  end

  describe '#new_character_encode' do
    it 'encodes the given character' do
      key = Key.new('040895')
      sample_array = ['a', 'f', 'g', 'd']

      first_encode = key.new_character_encode(sample_array, 2, key.a_shift)

      expect(first_encode).is_a?(String)
    end
  end

  describe '#not_nil?' do
    it 'finds whether the index number exists in the array' do
      key = Key.new('040895')
      sample_array = ['a', 'f', 'g', 'd']

      test_1 = key.not_nil?(sample_array, 2)
      test_2 = key.not_nil?(sample_array, 77)

      expect(test_1).to eq(true)
      expect(test_2).to eq(false)
    end
  end

  describe '#included_in_char_set?' do
    it 'tests whether given character is in character set' do
      key = Key.new('040895')
      sample_array = ['a', 'f', 'g', 'd', '@']

      test_1 = key.included_in_char_set?(sample_array, 0)
      test_2 = key.included_in_char_set?(sample_array, -1)

      expect(test_1).to eq(true)
      expect(test_2). to eq(false)
    end
  end

  describe '#not_nil_and_included?' do
    it 'returns true if the index number in array is not nil and the character at the index is included' do
      key = Key.new('040895')
      sample_array = ['a', 'f', 'g', 'd', '@']

      test_1 = key.not_nil_and_included?(sample_array, 2)
      test_2 = key.not_nil_and_included?(sample_array, 77)
      test_3 = key.not_nil_and_included?(sample_array, -1)

      expect(test_1).to eq(true)
      expect(test_2).to eq(false)
      expect(test_3).to eq(false)
    end
  end

  describe '#not_nil_not_included' do
    it 'returns true if the character at array index value is not nil and the character is not included in character set' do
      key = Key.new('040895')
      sample_array = ['a', 'f', 'g', 'd', '@']

      test_1 = key.not_nil_not_included?(sample_array, 2)
      test_2 = key.not_nil_not_included?(sample_array, 77)
      test_3 = key.not_nil_not_included?(sample_array, -1)

      expect(test_1).to eq(false)
      expect(test_2).to eq(false)
      expect(test_3).to eq(true)
    end
  end

  describe '#encode_iteration' do
    it 'completes one iteration of encode' do
      key = Key.new('040895')
      sample_array = ['a', 'f', 'g', 'd', '@']

      test_1 = key.encode_iteration(sample_array, 2, key.a_shift)
      test_2 = key.encode_iteration(sample_array, -1, key.a_shift)
      test_3 = key.encode_iteration(sample_array, 77, key.a_shift)

      expect(test_1).is_a?(String)
      expect(test_2).to eq('@')
      expect(test_3).to eq(nil)
    end
  end

  describe 'encode' do
    it 'encodes' do
      key = Key.new('040895')

      key.take_in_phrase('We gotta give Han more time')

      expect(key.encoded_string).not_to eq('we gotta give han more time')
      expect(key.encoded_string.length).to eq(27)
    end

    it 'encodes with characters not included' do
      key = Key.new('040895')

      key.take_in_phrase('We g!otta gi!ve Han more time')

      expect(key.encoded_string).not_to eq('we g!otta gi!ve han more time')
      expect(key.encoded_string.include?('!')).to eq(true)
      expect(key.encoded_string.length).to eq(29)
    end
  end

  describe '#remove_nils_from_encoded_array' do
    it 'removes any nils in an encoded array' do
      key = Key.new('040895')

      key.take_in_phrase('We g!otta gi!ve Han more time')
      encoded_phrase = key.encode

      expect(encoded_phrase.include?(nil)).to eq(true)

      remove_nils = key.remove_nils_from_encoded_array

      expect(remove_nils.include?(nil)).to eq(false)
    end
  end

  describe '#encoded_string' do
    it 'turns encoded array into a string' do
      key = Key.new('040895')

      key.take_in_phrase('We g!otta gi!ve Han more time')
      encoded_phrase = key.encode

      expect(encoded_phrase).is_a?(Array)

      string = key.encoded_string

      expect(string).is_a?(String)
    end
  end

  describe '#encoded_single_characters_array' do
    it 'splits every character of encoded string and puts the min an array' do
      key = Key.new('040895')

      key.take_in_phrase('We g!otta gi!ve Han more time')
      encoded_string = key.encoded_string

      expect(encoded_string).is_a?(String)

      encoded_array = key.encoded_single_characters_array

      expect(encoded_array).is_a?(Array)
    end
  end

  describe '#encoded_sets_of_four' do
    it 'breaks encoded string into sets of four' do
      key = Key.new('040895')

      key.take_in_phrase('We g!otta gi!ve Han more time')
      encoded_char_array = key.encoded_single_characters_array

      expect(encoded_char_array.length).to eq(29)

      sets_of_four = key.encoded_sets_of_four

      expect(sets_of_four).is_a?(Array)
    end
  end

  describe '#decode_first_index' do
    it 'finds given letter or space in character set and gives its index value' do
      key = Key.new('040895')
      sample_array = ['a', 'f', 'g', 'd']

      first_index = key.decode_first_index(sample_array, 2)

      expect(first_index).to eq(6)
    end
  end

  describe '#decode_first_rotation' do
    it 'rotates character array so that the given letter is in the zero position' do
      key = Key.new('040895')
      sample_array = ['a', 'f', 'g', 'd']

      first_rotation = key.decode_first_rotation(sample_array, 2)

      expect(first_rotation[0]).to eq('g')
    end
  end

  describe '#new_character_decode' do
    it 'decodes the given character' do
      key = Key.new('040895')
      sample_array = ['a', 'f', 'g', 'd']

      first_decode = key.new_character_decode(sample_array, 2, key.a_shift)

      expect(first_decode).is_a?(String)
    end
  end

  describe '#decode_iteration' do
    it 'completes one iteration of encode' do
      key = Key.new('040895')
      sample_array = ['a', 'f', 'g', 'd', '@']

      test_1 = key.decode_iteration(sample_array, 2, key.a_shift)
      test_2 = key.decode_iteration(sample_array, -1, key.a_shift)
      test_3 = key.decode_iteration(sample_array, 77, key.a_shift)

      expect(test_1).is_a?(String)
      expect(test_2).to eq('@')
      expect(test_3).to eq(nil)
    end
  end

  describe '#decode' do
    it 'decodes' do
      key = Key.new('040895')

      key.take_in_phrase('We gotta give Han more time')
      key.encode

      expect(key.decoded_string).to eq('we gotta give han more time')
    end

    it 'decodes with characters not included' do
      key = Key.new('040895')

      key.take_in_phrase('We g!otta give Han m!ore time')
      key.encode

      expect(key.decoded_string).to eq('we g!otta give han m!ore time')
    end
  end

  describe '#remove_nils_from_decoded_array' do
    it 'removes any nils in a decoded array' do
      key = Key.new('040895')

      key.take_in_phrase('We g!otta gi!ve Han more time')
      encoded_phrase = key.encode

      decode = key.decode

      expect(decode.include?(nil)).to eq(true)

      remove_nils = key.remove_nils_from_decoded_array

      expect(remove_nils.include?(nil)).to eq(false)
    end
  end

  describe '#decoded_string' do
    it 'returns the decoded string' do
      key = Key.new('040895')

      key.take_in_phrase('We g!otta give Han m!ore time')
      key.encode

      expect(key.decoded_string).to eq('we g!otta give han m!ore time')
    end
  end
end
