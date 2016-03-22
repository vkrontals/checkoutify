module Checkoutify
  class Item

    attr_reader :product_code, :name, :price

    def initialize(settings)
      @product_code = settings[:product_code]
      @name = settings[:name]
      @price = settings[:price]
    end

    private

    def remove_self(items)
      items.delete_if { |item| item == self }
    end

  end
end
