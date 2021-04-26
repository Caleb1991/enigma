class CodeRing
  attr_reader :key,
              :date,
              :phrase,
              :character_set

  def initialize(phrase, key, date)
    @phrase = phrase.downcase
    @key = key
    @date = date
    @character_set = ('a'..'z').to_a << ' '
  end

  def key_to_string_array
    string_array = @key.split('')
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

  def phrase_array
    if @phrase != nil
      @phrase.split('')
    end
  end

  def phrase_sets_of_four
    new = []
    phrase_array.each_slice(4) do |set|
      new << set
    end
      new
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
end
