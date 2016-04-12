module V1
  class LikesController < ApplicationController
    before_action :authenticate_user!
  end
end
