require 'bigdecimal'

module Checkoutify
  class Checkout

    attr_reader :basket

    def initialize(promo_rules = [])
      # TODO: checking for an array is not great, ideally it should be able to handle all enumerables,
      # this would need some refactoring
      raise Checkoutify::InvalidArgumentError unless promo_rules.is_a?(Array)

      @promo_rules = promo_rules
      @basket = []
    end

    def scan(item)
      @basket << item

      self
    end

    def total
      # TODO: applied promo order matters, should the total price discount apply to the total price
      # including or excluding other promo discounts?
      promo_rules.each do |promo|
        promo.apply(basket)
      end

      basket.reduce(0) do |sum, item|
        item_price = BigDecimal(item.price.to_s)
        sum += item_price

        sum
      end.round(2).to_f
    end

    private

    def promo_rules
      @promo_rules
    end

  end
end