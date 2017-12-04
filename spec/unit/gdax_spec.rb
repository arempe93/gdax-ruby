describe GDAX do
  context '#method_missing' do
    it 'should return config values using dot-syntax' do
      expect(GDAX.use_server_time).to be_falsey
    end
  end

  context '#respond_to_missing?' do
    it 'should return true for config value keys' do
      expect(GDAX.respond_to_missing?(:use_server_time)).to be_truthy
    end
  end
end
