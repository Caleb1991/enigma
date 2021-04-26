require './lib/encoder'

RSpec.describe Encoder do

  describe 'initialize' do
    it 'exists' do
      encode = Encoder.new('this', '12345', '040895')

      expect(encode).is_a?(Encoder)
    end

    it 'has an encoded phrase' do
      encode = Encoder.new('this', '12345', '040895')

      (expect(encode.encoded_phrase)).to eq('fdro')
    end

    it 'has an instance of a code ring' do
      encode = Encoder.new('this', '12345', '040895')

      expect(encode.code_ring).is_a?(CodeRing)
    end
  end

  describe '#code_ring_character_set' do
    it 'returns the code rings char set' do
      encode = Encoder.new('this', '12345', '040895')

      expect(encode.code_ring_character_set.length).to eq(27)
    end
  end

  describe '#encode_first_index' do
    it 'gives the first index number for code iteration' do
      encode = Encoder.new('this', '12345', '040895')
      sample_array = ['a', 'b', 'c', 'd', 'e']

      expect(encode.encode_first_index(sample_array, 0)).to eq(0)
    end
  end

  describe '#encode_first_rotation' do
    it 'gives the starting point for the letter to encode' do
      encode = Encoder.new('this', '12345', '040895')
      sample_array = ['a', 'b', 'c', 'd', 'e']

      expect(encode.encode_first_rotation(sample_array, 3)[0]).to eq('d')
    end
  end

  describe '#new_character_encode'do
    it 'encodes new character' do
      encode = Encoder.new('this', '12345', '040895')
      sample_array = ['a', 'b', 'c', 'd', 'e']

      expect(encode.new_character_encode(sample_array, 0, encode.code_ring.a_shift)).to eq('n')
    end
  end

  describe '#encode_iteration' do
    it 'completes one iteration of encode' do
      encode = Encoder.new('this', '12345', '040895')
      sample_array = ['a', 'b', 'c', 'd', 'e']

      expect(encode.encode_iteration(sample_array, 0, encode.code_ring.a_shift)).to eq('n')
    end
  end

  describe '#encode' do
    it 'encodes given phrase' do
      encode = Encoder.new('this', '12345', '040895')

      expect(encode.encode).to eq(['f', 'd', 'r', 'o'])
    end
  end

  describe '#remove_nils_from_encoded_array' do
    it 'removes any nils in encoded array' do
      encode = Encoder.new('thisl', '12345', '040895')

      expect(encode.encode.include?(nil)).to eq(true)
      expect(encode.remove_nils_from_encoded_array.include?(nil)).to eq(false)
    end
  end

  describe '#encoded_string' do
    it 'returns an encoded string' do
      encode = Encoder.new('this', '12345', '040895')

      expect(encode.encoded_string).to eq('fdro')
    end
  end
end
