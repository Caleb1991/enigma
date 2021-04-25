class Key
  attr_reader :character_set,
              :key,
              :a_shift,
              :b_shift,
              :c_shift,
              :d_shift,
              :date,
              :phrase,
              :range

  def initialize(date)
    @date = date
    @character_set = ('a'..'z').to_a << ' '
    @range = (1..9).to_a
    @key = random_number_join
    @a_shift = random_number_pairs_sums[0] + date_transformation[0]
    @b_shift = random_number_pairs_sums[1] + date_transformation[1]
    @c_shift = random_number_pairs_sums[2] + date_transformation[2]
    @d_shift = random_number_pairs_sums[3] + date_transformation[3]
    @phrase = nil
  end

  def random_number_generator
    new = @range.sample(4)
    new
  end

  def add_zero_to_random_number
    random_number_generator.unshift(0)
  end

  def random_number_join
    add_zero_to_random_number.join
  end

  def random_number_pairs
    pairs = []
    add_zero_to_random_number.each_cons(2) { |a| pairs << a}
    pairs
  end

  def random_number_pairs_sums
    random_number_pairs.map do |pair|
      pair.sum
    end
  end

  def date_to_integer
    @date.to_i
  end

  def square_date
    date_to_integer ** 2
  end

  def squared_date_to_string
    square_date.to_s
  end

  def string_date_sample
    squared_date_to_string[-4..-1]
  end

  def date_transformation
    string_date_sample.to_i
  end

  def take_in_phrase(phrase)
    @phrase = phrase.downcase
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

  def encode
    new = []
    phrase_sets_of_four.map do |array|

      new << array[0] = encode_iteration(array, 0, @a_shift)

      new << array[1] = encode_iteration(array, 1, @b_shift)

      new << array[2] = encode_iteration(array, 2, @c_shift)

      new << array[3] = encode_iteration(array, 3, @d_shift)
    end
    new
  end

  def remove_nils_from_encoded_array
    encode.compact
  end

  def encoded_string
    remove_nils_from_encoded_array.join
  end

  def encoded_single_characters_array
    if encoded_string != nil
      encoded_string.split('')
    end
  end

  def encoded_sets_of_four
    encoded_single_characters_array.each_slice(4)
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

    encoded_sets_of_four.map do |array|
      new << array[0] = decode_iteration(array, 0, @a_shift)

      new << array[1] = decode_iteration(array, 1, @b_shift)

      new << array[2] = decode_iteration(array, 2, @c_shift)

      new << array[3] = decode_iteration(array, 3, @d_shift)
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
