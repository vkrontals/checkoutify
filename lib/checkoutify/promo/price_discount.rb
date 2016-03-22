module Checkoutify
  class PriceDiscount < Promo
    attr_reader :discount, :min_total

    def initialize(rules)
      super({ product_code: rules[:promo_code],
              name: 'Total price discount',
              price: 0 })

      @min_total = rules[:min_total].to_f
      @discount = rules[:discount].to_f
    end

    def apply(items)
      remove_self(items)
      if promo_applies?(items)
        self.price = total(items) * discount * -1

        items << self
      end
    end

    private

    def price=(val)
      @price = val
    end

    def total(items)

      # TODO: this code is the same as in checkout.rb, should be refactored
      items.reduce(0) do |sum, item|
        item_price = BigDecimal(item.price.to_s)
        sum += item_price

        sum
      end.round(2).to_f
    end

    def promo_applies?(items)
      total(items) > min_total
    end

  end
end
