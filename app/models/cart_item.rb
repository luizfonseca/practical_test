class CartItem < ApplicationRecord
  belongs_to :product
  belongs_to :cart

  # Price responds to product directly
  delegate :price, to: :product
  delegate :name, to: :product


  validates :product, :cart, :quantity, presence: true


  after_save :change_cart_updated_at

  def final_price
    price * quantity
  end



  protected 
    def change_cart_updated_at
        self.cart.update_attribute(:updated_at, Time.now) 
    end
end
