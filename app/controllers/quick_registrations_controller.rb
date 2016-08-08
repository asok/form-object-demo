class QuickRegistrationsController < ApplicationController
  def new
    @user = QuickRegistration.new
  end

  def create
    @user = QuickRegistration.new(user_params)

    if @user.valid?
      User.create!(@user.persistable_attributes)
      redirect_to new_quick_registration_path, notice: "You have been registered"
    else
      render :new
    end
  end

  protected

  def user_params
    params.require(:user).permit(*QuickRegistration::Attributes)
  end
end
