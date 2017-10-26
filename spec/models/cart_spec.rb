require 'rails_helper'

RSpec.describe Cart, type: :model do

    describe "#expired?" do
        context "When the user created a cart recently" do
            subject(:cart) { create(:cart) }

            it { expect(cart.expired?).to be_falsy }
        end


        context "When the user hasnt updated his cart for 2 days" do
            subject(:cart) { create(:cart) }
            
            it "expect expired to be true" do 
                allow(cart).to receive(:updated_at).and_return(Time.now - 3.days)
                expect(cart.expired?).to be_truthy
            end
        end
    end

    describe "#total" do
        subject(:cart) { create(:cart) }
        before do 
            
            3.times do 
                cart.cart_items << create(:cart_item, quantity: 2, product: create(:product, price: 20.00))
            end
        end
        it "should return the total value multiplied by the quantity of the items inside the cart" do
            expect(cart.total).to eq(120.00)
        end


        it "should return 0.00 if there are no items inside" do
            cart.cart_items.destroy_all
            expect(cart.total).to eq(0.00)
        end
    end
end
