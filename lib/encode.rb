class Encode

  def initialize(phrase)
    @phrase = phrase.downcase
    @character_set = ('a'..'z').to_a << ' '
    @a_shift = random_number_pairs_sums[0] + date_transformation[0]
    @b_shift = random_number_pairs_sums[1] + date_transformation[1]
    @c_shift = random_number_pairs_sums[2] + date_transformation[2]
    @d_shift = random_number_pairs_sums[3] + date_transformation[3]
  end

  def phrase_array
    if @phrase != nil
      @phrase.split('')
    end
  end

  def phrase_sets_of_four
    phrase_array.each_slice(4)
  end

  def encode_first_index(block, block_index)
    @character_set.index(block[block_index])
  end

  def encode_first_rotation(block, block_index)
    @character_set.rotate(decode_first_index(block, block_index))
  end

  def new_character_encode(block, block_index, shift, new_array_index = 0)
    encode_first_rotation(block, block_index).rotate(shift)[new_array_index]
  end

  def not_nil?(block, index)
    block[index] != nil
  end

  def included_in_char_set?(block, index)
    @character_set.include?(block[index])
  end

  def not_nil_and_included?(block, index)
    not_nil?(block, index) && included_in_char_set?(block, index)
  end

  def not_nil_not_included?(block, index)
    not_nil?(block, index) && !included_in_char_set?(block, index)
  end

  def encode_iteration(block, index, shift)
    block[index] = if not_nil_and_included?(block, index)
      new_character_encode(block, index, shift)
    elsif not_nil_not_included?(block, index)
      block[index]
    else
      nil
    end
  end
