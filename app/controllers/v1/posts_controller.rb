module V1
  class PostsController < ApplicationController
    before_action :authenticate_user!

    private

    def post_params
      params.require(:post).permit(:message)
    end
  end
end
