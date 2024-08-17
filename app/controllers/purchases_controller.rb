class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:create, :index]
  before_action :redirect_user, only: [:index, :create]
  
  def index
    if @item.user_id == current_user.id
      redirect_to root_path
    end
    unless @item.purchase.blank?
      redirect_to root_path
    end
    @purchase_shipping_address = PurchaseShippingAddress.new
    gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
  end

  def create
    @purchase_shipping_address = PurchaseShippingAddress.new(purchase_shipping_address_params)
    if @purchase_shipping_address.valid?
      pay_item
      @purchase_shipping_address.save
      redirect_to root_path
    else
      gon.public_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private
  def purchase_shipping_address_params
    params.require(:purchase_shipping_address).permit(:post_code, :prefecture_id, :municipality, :street_address, :building, :telephone_number).merge(token: params[:token], user_id: current_user.id, item_id: @item.id)
  end

  def redirect_user
    @item = Item.find(params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item[:price],
        card: purchase_shipping_address_params[:token],
        currency: 'jpy'
      )
  end
end
