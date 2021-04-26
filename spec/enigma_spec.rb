require './lib/enigma'

RSpec.describe Enigma do

  describe 'initialize' do
    it 'exists' do
      enigma = Enigma.new

      expect(enigma).is_a?(Enigma)
    end

    it 'has no encoded_phrase by default' do
      enigma = Enigma.new

      expect(enigma.encoded_phrase).to eq(nil)
    end

    it 'has no decoded phrase by default' do
      enigma = Enigma.new

      expect(enigma.decoded_phrase).to eq(nil)
    end
  end

  describe '#key_length_not_5?' do
    it'returns true if key value is not 5' do
      enigma = Enigma.new

      expect(enigma.key_length_not_5?('12345')).to eq(false)
      expect(enigma.key_length_not_5?('1')).to eq(true)
    end
  end

  describe '#key_input_error_message' do
    it 'returns an error message' do
      enigma = Enigma.new

      expect(enigma.key_input_error_message).to eq('Please input five integers')
    end
  end

  describe '#date_length_not_six?' do
    it 'returns true if date is not six' do
      enigma = Enigma.new

      expect(enigma.date_length_not_six?('123456')).to eq(false)
      expect(enigma.date_length_not_six?('1')).to eq(true)
    end
  end

  describe '#date_input_error_message' do
    it 'returns an error message' do
      enigma = Enigma.new

      expect(enigma.date_input_error_message).to eq('Please input date as MMDDYY')
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

    it 'returns message if key is too long or too short' do
      enigma = Enigma.new
      encryption_1 = enigma.encrypt('hello world', '102715', '040895')
      encryption_2 = enigma.encrypt('hello world', '15', '040895')

      expect(encryption_1).to eq('Please input five integers')
      expect(encryption_2).to eq('Please input five integers')
    end

    it 'returns message if date is too long' do
      enigma = Enigma.new
      encryption_1 = enigma.encrypt('hello world', '12345', 'August 7th')
      encryption_2 = enigma.encrypt('hello world', '12345', '0')

      expect(encryption_1).to eq('Please input date as MMDDYY')
      expect(encryption_2).to eq('Please input date as MMDDYY')
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

    it 'returns message if key is too long or too short' do
      enigma = Enigma.new
      decryption_1 = enigma.decrypt('hello world', '102715', '040895')
      decryption_2 = enigma.decrypt('hello world', '15', '040895')

      expect(decryption_1).to eq('Please input five integers')
      expect(decryption_2).to eq('Please input five integers')
    end

    it 'returns message if date is too long' do
      enigma = Enigma.new
      decryption_1 = enigma.decrypt('hello world', '12345', 'August 7th')
      decryption_2 = enigma.decrypt('hello world', '12345', '0')

      expect(decryption_1).to eq('Please input date as MMDDYY')
      expect(decryption_2).to eq('Please input date as MMDDYY')
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

  describe '#today' do
    it 'returns todays date as MMDDYY' do
      enigma = Enigma.new

      expect(enigma.today).to eq(Time.now.strftime('%d%m%y'))
    end
  end
end
