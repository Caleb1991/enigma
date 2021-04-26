require './lib/decoder'

RSpec.describe Decoder do

  describe 'initialize' do
    it 'exists' do
      decode = Decoder.new('fdro', '12345', '040895')

      expect(decode).is_a?(Decoder)
    end

    it 'has a decoded phrase' do
      decode = Decoder.new('fdro', '12345', '040895')

      expect(decode.decoded_phrase).to eq('this')
    end

    it 'has an instance of code ring' do
      decode = Decoder.new('fdro', '12345', '040895')

      expect(decode.code_ring).is_a?(CodeRing)
    end
  end

  describe '#code_ring_character_set' do
    it 'returns the code rings char set' do
      encode = Encoder.new('this', '12345', '040895')

      expect(encode.code_ring_character_set.length).to eq(27)
    end
  end

  describe '#decode_first_index' do
    it 'gives the first index number for code iteration' do
      decode = Decoder.new('fdro', '12345', '040895')
      sample_array = ['a', 'b', 'c', 'd', 'e']

      expect(decode.decode_first_index(sample_array, 0)).to eq(0)
    end
  end

  describe '#decode_first_rotation' do
    it 'gives the starting point for the letter to decode' do
      decode = Decoder.new('fdro', '12345', '040895')
      sample_array = ['a', 'b', 'c', 'd', 'e']

      expect(decode.decode_first_rotation(sample_array, 3)[0]).to eq('d')
    end
  end

  describe '#new_character_decode'do
    it 'decodes new character' do
      decode = Decoder.new('fdro', '12345', '040895')
      sample_array = ['a', 'b', 'c', 'd', 'e']

      expect(decode.new_character_decode(sample_array, 0, decode.code_ring.a_shift)).to eq('o')
    end
  end

  describe '#decode_iteration' do
    it 'completes one iteration of decode' do
      decode = Decoder.new('fdro', '12345', '040895')
      sample_array = ['a', 'b', 'c', 'd', 'e']

      expect(decode.decode_iteration(sample_array, 0, decode.code_ring.a_shift)).to eq('o')
    end
  end

  describe '#decode' do
    it 'decodes given phrase' do
      decode = Decoder.new('fdro', '12345', '040895')

      expect(decode.decode).to eq(['t', 'h', 'i', 's'])
    end
  end

  describe '#remove_nils_from_decoded_array' do
    it 'removes any nils in decoded array' do
      decode = Decoder.new('fdrol', '12345', '040895')

      expect(decode.decode.include?(nil)).to eq(true)
      expect(decode.remove_nils_from_decoded_array.include?(nil)).to eq(false)
    end
  end

  describe '#decoded_string' do
    it 'returns an encoded string' do
      decode = Decoder.new('fdro', '12345', '040895')

      expect(decode.decoded_string).to eq('this')
    end
  end
end
