module V1
  class UsersController < ApplicationController
    before_action :authenticate_user!, except: :create

    def index
      users = User.all
      render json: serialize_models(users)
    end

    def show
      user = User.friendly.find(params[:id])
      render json: serialize_model(user)
    end
  end
end

