require './code_ring'

class Encoder
  attr_reader :encoded_phrase

  def initialize(phrase, key, date)
    @code_ring = CodeRing.new(phrase, key, date)
    @encoded_phrase = encoded_string
  end

  def code_ring_character_set
    @code_ring.character_set
  end

  def encode_first_index(block, block_index)
    code_ring_character_set.index(block[block_index])
  end

  def encode_first_rotation(block, block_index)
    code_ring_character_set.rotate(encode_first_index(block, block_index))
  end

  def new_character_encode(block, block_index, shift, new_array_index = 0)
    encode_first_rotation(block, block_index).rotate(shift)[new_array_index]
  end

  def encode_iteration(block, index, shift)
    block[index] = if @code_ring.not_nil_and_included?(block, index)
      new_character_encode(block, index, shift)
    elsif @code_ring.not_nil_not_included?(block, index)
      block[index]
    else
      nil
    end
  end

  def encode
    new = []
    @code_ring.phrase_sets_of_four.map do |array|

      new << array[0] = encode_iteration(array, 0, @code_ring.a_shift)

      new << array[1] = encode_iteration(array, 1, @code_ring.b_shift)

      new << array[2] = encode_iteration(array, 2, @code_ring.c_shift)

      new << array[3] = encode_iteration(array, 3, @code_ring.d_shift)
    end
    new
  end

  def remove_nils_from_encoded_array
    encode.compact
  end

  def encoded_string
    remove_nils_from_encoded_array.join
  end
end
