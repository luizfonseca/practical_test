class Cart < ApplicationRecord
    belongs_to :user
    has_many :cart_items


    validates_presence_of :user




    def expired? 
        self.updated_at <= (Time.now - 2.days)
    end

    def total
        self.cart_items.map(&:final_price).inject(:+).to_f
    end


end
