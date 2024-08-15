class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index]

  def index
    @purchase_shipping_address = PurchaseShippingAddress.new
    @item = Item.find(params[:item_id])
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

  def create
    @item = Item.find(params[:item_id])
    @purchase_shipping_address = PurchaseShippingAddress.new(purchase_shipping_address_params.merge(user_id: current_user.id, item_id: @item.id))
    
    if @purchase_shipping_address.valid?
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item[:price],
        card: purchase_shipping_address_params[:token],
        currency: 'jpy'
      )
      @purchase_shipping_address.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private
  def purchase_shipping_address_params
    params.require(:purchase_shipping_address).permit(:post_code, :prefecture_id, :municipality, :street_address, :building, :telephone_number).merge(token: params[:token])
  end

end
