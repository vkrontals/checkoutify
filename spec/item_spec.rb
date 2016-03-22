require 'spec_helper'

describe Checkoutify::Item do

  describe '#initialize' do
    let(:settings) { { product_code: '001', name: 'some item', price: 99.99 } }
    subject { Checkoutify::Item.new(settings) }

    it 'initializes an item correctly' do
      expect(subject.name).to eq 'some item'
      expect(subject.price).to eq 99.99
      expect(subject.product_code).to eq '001'
    end
  end
end
