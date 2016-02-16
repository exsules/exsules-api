class RegistrationsController < Devise::RegistrationsController
  def create
    user = User.new(sign_up_params)
    if user.save
      data = {
        success: true,
        message: 'Registration success message, yaya!'
      }
      render json: { user: data }, status: 201
    else
      warden.custom_failure!
      render json: { errors: user.errors.full_messages }, status: 422
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:username, :email, :password)
  end
end
