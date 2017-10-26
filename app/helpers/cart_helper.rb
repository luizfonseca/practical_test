module CartHelper

    def display_cart_info(user)
        return unless user
        if user.carts.last && !user.carts.last.expired?
            "(#{user.carts.last.cart_items.count})"
        end
    end
end
