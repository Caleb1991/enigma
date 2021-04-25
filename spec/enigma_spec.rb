require './lib/enigma'
require 'SimpleCOV'

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

      expect(enigma.today).to eq('250421')
    end
  end
end
