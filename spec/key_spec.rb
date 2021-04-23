require './lib/key'

RSpec.describe Key do

  describe 'initialize' do
    it 'exists' do
      key = Key.new

      expect(key).is_a?(Key)
    end
  end
end
