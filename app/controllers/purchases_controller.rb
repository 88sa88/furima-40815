class PurchasesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :index]

  def index
    
  end

end
