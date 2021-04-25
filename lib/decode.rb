require './codering'

class Decode < CodeRing
  attr_reader :decoded_phrase

  def initialize(phrase, key, date)
    super(phrase, key, date)
    @decoded_phrase = decoded_string
  end

  def decode_first_index(block, block_index)
    @character_set.index(block[block_index])
  end

  def decode_first_rotation(block, block_index)
    @character_set.rotate(decode_first_index(block, block_index))
  end

  def new_character_decode(block, block_index, shift, new_array_index = 0)
    decode_first_rotation(block, block_index).rotate(-shift)[new_array_index]
  end

  def decode_iteration(block, index, shift)
    if not_nil_and_included?(block, index)
      new_character_decode(block, index, shift)
    elsif not_nil_not_included?(block, index)
      block[index]
    else
      nil
    end
  end

  def decode
    new = []

    phrase_sets_of_four.map do |array|
      new << array[0] = decode_iteration(array, 0, a_shift)

      new << array[1] = decode_iteration(array, 1, b_shift)

      new << array[2] = decode_iteration(array, 2, c_shift)

      new << array[3] = decode_iteration(array, 3, d_shift)
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
