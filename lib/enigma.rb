class Enigma
  attr_reader :encrypted,
              :encoded_phrase,
              :date,
              :key,
              :decoded_phrase

  def initialize
    @date = nil
    @key = nil
    @key_and_date = nil
    @encoded_phrase = nil
    @decoded_phrase = nil
    @phrase = nil
    @character_set = ('a'..'z').to_a << ' '
  end

  def a_shift
    key_pairs_integers[0] + date_transformation[0]
  end

  def b_shift
    key_pairs_integers[1] + date_transformation[1]
  end

  def c_shift
    key_pairs_integers[2] + date_transformation[2]
  end

  def d_shift
    key_pairs_integers[3] + date_transformation[3]
  end

  def encrypt(phrase, key = random_key_string, date = today)
    @key = key
    @date = date
    @phrase = phrase.downcase
    @encoded_phrase = encoded_string

    encrypted = {
      encryption: @encoded_phrase,
      key: @key,
      date: @date
    }
  end

  def decrypt(phrase, key, date = today)
    @phrase = phrase.downcase
    @key = key
    @date = date
    @decoded_phrase = decoded_string

    decryption = {
      decryption: @decoded_phrase,
      key: @key,
      date: @date
    }
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

  def key_to_string_array
    string_array = @key.split('')
  end

  def create_range
    (0..9).to_a
  end

  def select_randomly_from_range
    create_range.sample(5)
  end

  def random_key_string
    select_randomly_from_range.join
  end

  def key_string_array_to_integer_array
    key_to_string_array.map do |string|
      string.to_i
    end
  end

  def key_pairs
    pairs = []

    key_string_array_to_integer_array.each_cons(2) { |a| pairs << a}
    pairs
  end

  def key_pairs_integers
    key_pairs.map do |pair|
      pair.join.to_i
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
    squared_date_to_string[-4..-1].split('')
  end

  def date_transformation
    string_date_sample.map do |string|
      string.to_i
    end
  end

  def today
    Time.now.strftime('%d%m%y')
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
    @character_set.rotate(encode_first_index(block, block_index))
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

      new << array[0] = encode_iteration(array, 0, a_shift)

      new << array[1] = encode_iteration(array, 1, b_shift)

      new << array[2] = encode_iteration(array, 2, c_shift)

      new << array[3] = encode_iteration(array, 3, d_shift)
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
