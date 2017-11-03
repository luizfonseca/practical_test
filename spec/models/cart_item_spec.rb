require 'rails_helper'

RSpec.describe CartItem, type: :model do
    describe "#final_price" do
        subject(:cart_item) { create(:cart_item, quantity: 2, product: create(:product, price: 20.00)) }

        it "should return the value times quantity" do
            expect(cart_item.final_price).to eq(40.00)
        end

        it { expect(cart_item.final_price).to_not eq(20.00) }
    end 


    describe "#change_cart_updated_at" do

        subject(:cart_item) { create(:cart_item, quantity: 2, product: create(:product, price: 20.00)) }
        before { cart_item.cart.update_attribute(:updated_at, Time.now - 1.day) } 

        it "should update the parent cart `updated_at` whenever a item inside changes" do
            allow(Time).to receive(:now).and_return("2017-10-26 17:00:00 +0200".to_time)
            cart_item.update_attribute(:quantity, 1)
            expect(cart_item.cart.updated_at).to eq("2017-10-26 17:00:00 +0200".to_time)
        end
    end



    describe "#increase_quantity" do
      subject(:cart_item) { create(:cart_item, quantity: 1, product: create(:product, price: 20.00)) }


      it { expect { cart_item.increase_quantity! }.to change { cart_item.quantity }.from(1).to(2) }
    end



    describe "#decrease_quantity" do
      subject(:cart_item) { create(:cart_item, quantity: 2, product: create(:product, price: 20.00)) }


      it { expect { cart_item.decrease_quantity! }.to change { cart_item.quantity }.from(2).to(1) }
    end



    describe "#remove_from_cart_if_quantity_zero" do
      subject(:cart_item) { create(:cart_item, quantity: 1, product: create(:product, price: 20.00)) }
      before { cart_item.decrease_quantity! }
      
      it { expect { cart_item.save! }.to change(CartItem, :count).by(-1) }
    end
end
