module V1
  class UsersController < ApplicationController
    before_action :authenticate_user!, except: :create

  end
end

