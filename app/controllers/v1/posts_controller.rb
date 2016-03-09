module V1
  class PostsController < ApplicationController
    before_action :authenticate_user!

    def create
      p params
      user = User.find(params[:data][:relationships][:user][:data][:id])
      post = user.posts.new(post_params)
      post.source = current_user

      if post.save
        render json: serialize_model(post)
      else
        render json: { errors: post.errors.full_messages }, status: 422
      end
    end

    def show_relationship
      user = User.find(params[:id])
      render json: serialize_models(user.posts)
    end

    private

    def post_params
      params.require(:data).
        require(:attributes).
        permit(:message)
    end
  end
end
