class AddressesController < ApplicationController

  def new
    @address = Address.new
    @user = User.find(params[:user_id])
  end
end
