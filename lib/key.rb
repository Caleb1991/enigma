class Key
  attr_reader :alphabet,
              :random_number,
              :a_shift,
              :b_shift,
              :c_shift,
              :d_shift,
              :date,
              :phrase

  def initialize(date)
    @date = date
    @alphabet = ('a'..'z').to_a << ' '
    @random_number = random_number_generator
    @a_shift = shift[0].sum + date_transformation[0]
    @b_shift = shift[1].sum + date_transformation[1]
    @c_shift = shift[2].sum + date_transformation[2]
    @d_shift = shift[3].sum + date_transformation[3]
    @phrase = nil
  end

  def random_number_generator
    range = (1..9).to_a
    new = range.sample(5)
    new
  end

  def shift
    pairs = []
    @random_number.each_cons(2) { |a| pairs << a}
    pairs
  end

  def date_transformation
    new = @date.to_i ** 2
    new.to_s[-4..-1].to_i
  end

  def take_in_phrase(phrase)
    @phrase = phrase.downcase
  end
end
