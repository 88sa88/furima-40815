class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index]

  def index
    @purchase_shipping_address = PurchaseShippingAddress.new
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_shipping_address = PurchaseShippingAddress.new(purchase_shipping_address_params.merge(user_id: current_user.id, item_id: @item.id))
    
    if @purchase_shipping_address.valid?
      @purchase_shipping_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private
  def purchase_shipping_address_params
    params.require(:purchase_shipping_address).permit(:post_code, :prefecture_id, :municipality, :street_address, :building, :telephone_number)
  end

end
