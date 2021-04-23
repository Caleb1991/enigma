require './lib/key'

RSpec.describe Key do

  describe 'initialize' do
    it 'exists' do
      key = Key.new

      expect(key).is_a?(Key)
    end

    it 'has a range from a-z plus a space' do
      key = Key.new

      expect(key.library.length).to eq(27)
    end
  end
end
