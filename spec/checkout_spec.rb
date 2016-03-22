require 'spec_helper'

describe Checkoutify::Checkout do
  let (:item1) { Checkoutify::Item.new({ price: 9.25,  product_code: '001', name: 'Lavender heart' }) }
  let (:item2) { Checkoutify::Item.new({ price: 45.0,  product_code: '002', name: 'Personalised cufflinks' }) }
  let (:item3) { Checkoutify::Item.new({ price: 19.95, product_code: '003', name: 'Kids T-shirt' }) }

  let (:promo1) { Checkoutify::PriceDiscount.new({ min_total: 60.0, discount: 0.1, promo_code: 'pd01' }) }
  let (:promo2) { Checkoutify::MultiBuy.new({ product_code: '001', min_buy: 2, discount: 0.75, promo_code: 'mb01' }) }

 describe '#new' do
   subject { Checkoutify::Checkout.new('foo') }

   it 'raises an error if promo rules is not an array' do
     expect { subject }.to raise_error(Checkoutify::InvalidArgumentError)
   end
 end

  describe '#total' do

    let (:co) { Checkoutify::Checkout.new([promo2, promo1]) }

    subject { co.total }

    it 'returns a correct total value' do
      co.scan(item1)
          .scan(item2)
          .scan(item3)

      expect(subject).to eq 66.78
    end

    it 'returns a correct total value' do
      co.scan(item1)
          .scan(item3)
          .scan(item1)

      expect(subject).to eq 36.95
    end

    it 'returns a correct total value' do
      co.scan(item1)
          .scan(item2)
          .scan(item1)
          .scan(item3)

      expect(subject).to eq 73.76
    end

  end

  describe '#scan' do
    let (:co) { Checkoutify::Checkout.new }
    subject { co.basket }

    it 'adds a scanned item to basket' do
      co.scan(item1)

      expect(subject).to include(item1)
    end
  end

end
