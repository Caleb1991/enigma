require './lib/encode'

RSpec.describe Encode do

  describe 'initialize' do
    it 'exists' do
      encode = Encode.new('this', '12345', '040895')

      expect(encode).is_a?(Encode)
    end
  end
end
