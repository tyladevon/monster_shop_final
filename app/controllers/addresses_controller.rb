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

  def edit
    @user = User.find(params[:user_id])
    @address = Address.find(params[:id])
  end

  def update
    @user = current_user
    @address = Address.find(params[:id])
    if params[:commit] == "Submit"
      if @address.update(address_params)
        flash[:success] = "Address has been updated"
    redirect_to profile_path
    else
      flash[:error] = @address.errors.full_messages.to_sentence
      redirect_to edit_user_address_path(@user.id, @address.id)
      end
    end
  end

  def destroy
    address = Address.find(params[:id])
    shipped = address.orders.any? do |order|
      order.status == "shipped"
    end
    if !shipped
      address.destroy
      redirect_to "/profile"
    else
      flash[:error] = "Can't delete address"
      redirect_to "/profile"
    end
  end

  private
  def address_params
    params.require(:address).permit(:nickname, :name, :address, :city, :state, :zip)
  end

end
