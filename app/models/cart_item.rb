class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  # Price responds to product directly
  delegate :price, to: :product
  delegate :name, to: :product


  validates :product, :cart, :quantity, presence: true
  after_save :change_cart_updated_at
  after_save :remove_from_cart_if_quantity_zero

  def final_price
    price * quantity
  end


  def decrease_quantity!
    self.quantity -= 1
  end


  def increase_quantity!
    self.quantity += 1
  end


  protected 

    def remove_from_cart_if_quantity_zero
      self.destroy! if self.quantity <= 0
    end

    def change_cart_updated_at
        self.cart.update_attribute(:updated_at, Time.now) 
    end
end
