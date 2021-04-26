require './encoder'
require './decoder'

class Enigma
  attr_reader :encoded_phrase,
              :decoded_phrase

  def initialize
    @encoded_phrase = nil
    @decoded_phrase = nil
  end

  def key_length_not_5?(key)
    key.length != 5
  end

  def key_input_error_message
    'Please input five integers'
  end

  def date_length_not_six?(date)
    date.length != 6
  end

  def date_input_error_message
    'Please input date as MMDDYY'
  end

  def encrypt(phrase, key = random_key_string, date = today)
    if key_length_not_5?(key)
      key_input_error_message
    elsif date_length_not_six?(date)
      date_input_error_message
    else
    encoded = Encoder.new(phrase, key, date)
    @encoded_phrase = encoded.encoded_phrase

    encrypted = {
        encryption: encoded.encoded_phrase,
        key: key,
        date: date
      }
    end
  end

  def decrypt(phrase, key, date = today)
    if key_length_not_5?(key)
      key_input_error_message
    elsif date_length_not_six?(date)
      date_input_error_message
    else
      decoded = Decoder.new(phrase, key, date)
      @decoded_phrase = decoded.decoded_phrase

      decryption = {
        decryption: decoded.decoded_phrase,
        key: key,
        date: date
      }
    end
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

  def today
    Time.now.strftime('%d%m%y')
  end
end
