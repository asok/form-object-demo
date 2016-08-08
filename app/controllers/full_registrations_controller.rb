class FullRegistrationsController < ApplicationController
  def new
    @user = FullRegistration.new
  end

  def create
    @user = FullRegistration.new(user_params)

    if @user.valid?
      User.create!(@user.persistable_attributes)
      redirect_to new_quick_registration_path, notice: "You have been registered"
    else
      render :new
    end
  end

  protected

  def user_params
    params.require(:user).permit(*FullRegistration::Attributes)
  end
end
