require 'spec_helper'
require 'ostruct'

describe Checkoutify::PriceDiscount do

  let(:items) { [
    OpenStruct.new({ price: 11.11 }),
    OpenStruct.new({ price: 11.11 }),
    OpenStruct.new({ price: 22.22 }),
    OpenStruct.new({ price: 33.33 }),
    OpenStruct.new({ price: 44.44 })
  ] }

  let(:rule) { { promo_code: 'xx1', min_total: 11.1, discount: 0.15 } }

  describe '#initialize' do
    subject { Checkoutify::PriceDiscount.new(rule) }

    it 'initializes the promo correctly' do
      expect(subject.min_total).to eq 11.1
      expect(subject.discount).to eq 0.15
      expect(subject.product_code).to eq 'xx1'
      expect(subject.name).to eq 'Total price discount'
      expect(subject.price).to eq 0
    end
  end

  describe '#apply' do
    let(:co) { Checkoutify::PriceDiscount.new(rule) }

    it 'adds a discount to items if rules apply' do
      co.apply(items)
      expect(items).to include(co)
      expect(co.price.round(2)).to eq(-18.33)
    end

    it 'it does nothing to items if rules not apply' do
      rule[:min_total] = 99999
      co.apply(items)
      expect(items).not_to include(co)
      expect(co.price).to eq(0)
    end

    it 'does not apply the discount more than once' do
      co.apply(items)
      co.apply(items)
      expect(items).to include(co)
      expect(co.price.round(2)).to eq(-18.33)
    end
  end

end

