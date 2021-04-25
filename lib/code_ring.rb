class CodeRing
  attr_reader :key,
              :date,
              :range,
              :character_set,
              :a_shift,
              :b_shift,
              :c_shift,
              :d_shift

  def initialize(key = random_key_string, date = today)
    @key = key
    @date = date
    @character_set = ('a'..'z').to_a << ' '
    @a_shift = key_pairs_sums[0] + date_transformation[0]
    @b_shift = key_pairs_sums[1] + date_transformation[1]
    @c_shift = key_pairs_sums[2] + date_transformation[2]
    @d_shift = key_pairs_sums[3] + date_transformation[3]
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

  def key_pairs_sums
    key_pairs.map do |pair|
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
end
