module Checkoutify
  class MultiBuy < Promo
    attr_reader :product_id, :min_buy, :discount

    def initialize(rules)
      super({ product_code: rules[:promo_code],
              name: 'Multi-buy discount',
              price: 0 })

      @product_id = rules[:product_code]
      @min_buy    = rules[:min_buy].to_i
      @discount = BigDecimal(rules[:discount].to_s)
    end

    def apply(items)
      if promo_items(items).count >= min_buy
        remove_self(items)
        self.price = 0
        promo_items(items).each do
          self.price -= discount
        end

       items << self
      end
    end

    private

    def promo_items(items)
      items.select { |item| item.product_code == product_id }
    end

    def price=(new_val)
      @price = new_val
    end

  end
end
