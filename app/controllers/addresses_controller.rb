class AddressesController < ApplicationController

  def new
    @address = Address.new
    @user = User.find(params[:user_id])
  end

  def create
    @user = current_user
    @address = @user.addresses.create(address_params)
    if @address.save
      redirect_to profile_path
      flash[:success] = "Welcome #{@user.name}!"
    else
      flash[:error] = "Please fill in all fields to finish registration"
      redirect_to "/users/#{@user.id}/addresses/new"
    end
  end

  private
  def address_params
    params.require(:address).permit(:nickname, :name, :address, :city, :state, :zip)
  end

end
