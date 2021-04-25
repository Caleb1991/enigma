require './lib/enigma'
require 'SimpleCOV'

RSpec.describe Enigma do

  describe 'initialize' do
    it 'exists' do
      enigma = Enigma.new

      expect(enigma).is_a?(Enigma)
    end
  end

  describe 'a_shift' do
    it 'shifts a letter that many spaces' do
      enigma = Enigma.new
      encryption = enigma.encrypt('hello world', '02715', '040895')

      expect(enigma.a_shift).to eq(3)
    end
  end

  describe 'b_shift' do
    it 'shifts a letter that many spaces' do
      enigma = Enigma.new
      encryption = enigma.encrypt('hello world', '02715', '040895')

      expect(enigma.b_shift).to eq(27)
    end
  end

  describe 'c_shift' do
    it 'shifts a letter that many spaces' do
      enigma = Enigma.new
      encryption = enigma.encrypt('hello world', '02715', '040895')

      expect(enigma.c_shift).to eq(73)
    end
  end

  describe 'd_shift' do
    it 'shifts a letter that many spaces' do
      enigma = Enigma.new
      encryption = enigma.encrypt('hello world', '02715', '040895')

      expect(enigma.d_shift).to eq(20)
    end
  end

  describe '#encrypt' do
    it 'reutrns hash of encrypted phrase with key and date' do
      enigma = Enigma.new
      encryption = enigma.encrypt('hello world', '02715', '040895')

      expected = {
        encryption: 'keder ohulw',
        key: '02715',
        date: '040895'
      }

      expect(encryption).to eq(expected)
    end
  end

  describe '#decrypt' do
    it 'decodes a message' do
      enigma = Enigma.new
      decryption = enigma.decrypt('keder ohulw', '02715', '040895')

      expected = {
        decryption: 'hello world',
        key: '02715',
        date: '040895'
      }

      expect(decryption).to eq(expected)
    end
  end

  describe '#encoded_single_characters_array' do
    it 'splits every character of encoded string and puts the min an array' do
      enigma = Enigma.new

      enigma.encrypt('hello world')
      encoded_string = enigma.encoded_string

      expect(encoded_string).is_a?(String)

      encoded_array = enigma.encoded_single_characters_array

      expect(encoded_array).is_a?(Array)
    end
  end

  describe '#encoded_sets_of_four' do
    it 'breaks encoded string into sets of four' do
      enigma = Enigma.new

      enigma.encrypt('hello world')
      encoded_char_array = enigma.encoded_single_characters_array

      expect(encoded_char_array.length).to eq(11)

      sets_of_four = enigma.encoded_sets_of_four

      expect(sets_of_four).is_a?(Array)
    end
  end

  describe '#decode_first_index' do
    it 'finds given letter or space in character set and gives its index value' do
      enigma = Enigma.new
      sample_array = ['a', 'f', 'g', 'd']

      first_index = enigma.decode_first_index(sample_array, 2)

      expect(first_index).to eq(6)
    end
  end

  describe '#decode_first_rotation' do
    it 'rotates character array so that the given letter is in the zero position' do
      enigma = Enigma.new
      sample_array = ['a', 'f', 'g', 'd']

      first_rotation = enigma.decode_first_rotation(sample_array, 2)

      expect(first_rotation[0]).to eq('g')
    end
  end

  describe '#new_character_decode' do
    it 'decodes the given character' do
      enigma = Enigma.new
      enigma.encrypt('hello world')
      sample_array = ['a', 'f', 'g', 'd']

      first_decode = enigma.new_character_decode(sample_array, 2, enigma.a_shift)

      expect(first_decode).is_a?(String)
    end
  end

  describe '#decode_iteration' do
    it 'completes one iteration of encode' do
      enigma = Enigma.new
      sample_array = ['a', 'f', 'g', '@']
      enigma.encrypt('afgd@')


      test_1 = enigma.decode_iteration(sample_array, 2, enigma.a_shift)
      test_2 = enigma.decode_iteration(sample_array, -1, enigma.a_shift)
      test_3 = enigma.decode_iteration(sample_array, 77, enigma.a_shift)

      expect(test_1).is_a?(String)
      expect(test_2).to eq('@')
      expect(test_3).to eq(nil)
    end
  end

  describe '#decode' do
    it 'decodes' do
      enigma = Enigma.new

      encryption = enigma.encrypt('We gotta give Han more time', '19283', '080895')
      decryption = enigma.decrypt(encryption[:encryption], '19283', '080895')
      expect(decryption[:decryption]).to eq('we gotta give han more time')
    end

    it 'decodes with characters not included' do
      enigma = Enigma.new

      encryption = enigma.encrypt('We g!otta give Han m!ore time',  '19283', '080895')
      decryption = enigma.decrypt(encryption[:encryption], '19283', '080895')

      expect(decryption[:decryption]).to eq('we g!otta give han m!ore time')
    end
  end

  describe '#create_range' do
    it 'creates a range from 0 to 9' do
      enigma = Enigma.new

      expect(enigma.create_range.length).to eq(10)
    end
  end

  describe '#select_randomly_from_range' do
    it 'randomly selects five numbers from range' do
      enigma = Enigma.new

      expect(enigma.select_randomly_from_range.length).to eq(5)
    end
  end

  describe '#random_key_string' do
    it 'turns randomly selected key to a string' do
      enigma = Enigma.new

      expect(enigma.random_key_string).is_a?(String)
    end
  end

  describe '#key_string_array_to_integer_array' do
    it 'converts key to array of strings' do
      enigma = Enigma.new
      encryption = enigma.encrypt('hello world', '02715', '040895')

      expected = ['0', '2', '7', '1', '5']

      expect(enigma.key_to_string_array).to eq(expected)
    end
  end

  describe '#key_string_array_to_integer_array' do
    it 'takes key string and turns it into an array of integers' do
      enigma = Enigma.new
      encryption = enigma.encrypt('hello world', '02715', '040895')

      expect(enigma.key_string_array_to_integer_array).to eq([0, 2, 7, 1, 5])
    end
  end
end
