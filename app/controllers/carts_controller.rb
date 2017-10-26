class CartsController < ApplicationController

    before_action :authenticate_user!
    before_action :set_cart, except: [:show]


    def show 
        @cart = current_user.carts.last || nil
    end

    # TODO: refactor
    def decrease_quantity
        @item = CartItem.find(params[:id])
        @item.quantity -= 1
        @item.save!

        if @item.quantity <= 0 
            @item.destroy
        end

        redirect_to cart_path
        
    end

    # TODO: refactor
    def increase_quantity
        @item = CartItem.find(params[:id])
        @item.quantity += 1
        @item.save!


        redirect_to cart_path
    end


    # POST /cart/add
    def add_to_cart
        @product = Product.find(params[:id])
        @cart.cart_items <<  CartItem.create(product: @product, quantity: 1)
        flash[:notice] = "Added #{@product.name} to cart"
        redirect_to products_path
    end


    private 
        def set_cart 
            @cart = current_user.carts.last.expired? ? Cart.create(user: current_user) : current_user.carts.last
        end
end
