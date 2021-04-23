class Key
  attr_reader :library

  def initialize
    @library = ('a'..'z').to_a << ' '
  end
end
