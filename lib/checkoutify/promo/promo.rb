module Checkoutify
  class Promo < Item

    def apply(items)
      raise Checkoutify::NotImplementedError, 'You must implement the apply method'
    end
  end
end