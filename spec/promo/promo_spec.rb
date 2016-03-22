require 'spec_helper'

describe Checkoutify::Promo do

  describe '#apply' do
    let(:settings) { { product_code: '001', name: 'some item', price: 99.99 } }

    subject { Checkoutify::Promo.new(settings).apply('foo') }

    it 'raises an NotImplemented exception so that child classes know it is needed' do
      expect { subject }.to raise_error(Checkoutify::NotImplementedError)
    end
  end
end

