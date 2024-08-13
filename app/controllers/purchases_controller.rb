class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index]

  def index
    @purchase_shipping_address = PurchaseShippingAddress.new
  end

end
