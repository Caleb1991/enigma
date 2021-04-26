require './code_ring'

class Decoder
  attr_reader :decoded_phrase

  def initialize(phrase, key, date)
    @code_ring = CodeRing.new(phrase, key, date)
    @decoded_phrase = decoded_string
  end

  def code_ring_character_set
    @code_ring.character_set
  end

  def decode_first_index(block, block_index)
    code_ring_character_set.index(block[block_index])
  end

  def decode_first_rotation(block, block_index)
    code_ring_character_set.rotate(decode_first_index(block, block_index))
  end

  def new_character_decode(block, block_index, shift, new_array_index = 0)
    decode_first_rotation(block, block_index).rotate(-shift)[new_array_index]
  end

  def decode_iteration(block, index, shift)
    if @code_ring.not_nil_and_included?(block, index)
      new_character_decode(block, index, shift)
    elsif @code_ring.not_nil_not_included?(block, index)
      block[index]
    else
      nil
    end
  end

  def decode
    new = []

    @code_ring.phrase_sets_of_four.map do |array|
      new << array[0] = decode_iteration(array, 0, @code_ring.a_shift)

      new << array[1] = decode_iteration(array, 1, @code_ring.b_shift)

      new << array[2] = decode_iteration(array, 2, @code_ring.c_shift)

      new << array[3] = decode_iteration(array, 3, @code_ring.d_shift)
    end
    new
  end

  def remove_nils_from_decoded_array
    decode.compact
  end

  def decoded_string
    remove_nils_from_decoded_array.join
  end
end
