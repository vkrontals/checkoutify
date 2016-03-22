require 'spec_helper'
require 'ostruct'

describe Checkoutify::MultiBuy do

  let(:items) { [
    OpenStruct.new({ price: 11.11, product_code: '001' }),
    OpenStruct.new({ price: 11.11, product_code: '001' }),
    OpenStruct.new({ price: 22.22, product_code: '002' }),
    OpenStruct.new({ price: 33.33, product_code: '003' }),
    OpenStruct.new({ price: 44.44, product_code: '004' })
  ] }

  let(:rule) { { promo_code: 'df1', product_code: '001',  min_buy: 2, discount: 5.55 } }

  describe '#initialize' do
    subject { Checkoutify::MultiBuy.new(rule) }

    it 'initializes the promo correctly' do
      expect(subject.product_id).to eq '001'
      expect(subject.min_buy).to eq 2
      expect(subject.discount).to eq 5.55
      expect(subject.product_code).to eq 'df1'
      expect(subject.name).to eq 'Multi-buy discount'
      expect(subject.price).to eq 0
    end
  end

  describe '#apply' do
    let(:co) { Checkoutify::MultiBuy.new(rule) }

    it 'adds a discount to items if rules apply' do
      co.apply(items)
      expect(items).to include(co)
      expect(co.price).to eq(-11.1)
    end

    it 'it does nothing to items if rules not apply' do
      rule[:min_buy] = 999
      co.apply(items)
      expect(items).not_to include(co)
      expect(co.price).to eq(0)
    end

    it 'does not add discount more than once' do
      co.apply(items)
      co.apply(items)
      expect(items).to include(co)
      expect(co.price).to eq(-11.1)
    end


  end

end

