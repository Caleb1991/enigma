class Key
  attr_reader :library,
              :random_number,
              :a_shift,
              :b_shift,
              :c_shift,
              :d_shift

  def initialize
    @library = ('a'..'z').to_a << ' '
    @random_number = random_number_generator
    @a_shift = shift[0].sum + date_transformation(date)[0]
    @b_shift = shift[1].sum + date_transformation(date)[1]
    @c_shift = shift[2].sum + date_transformation(date)[2]
    @d_shift = shift[3].sum + date_transformation(date)[3]
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
end
