module V1
  class SearchesController < ApplicationController
    before_action :authenticate_user!

    def index
      search_query = User.search(params[:q], {
        fields: ["id", "first_name", "last_name", "username"],
        limit: 10
      })

      render json: JSONAPI::ResourceSerializer.new(::SearchResource).
        serialize_to_hash(::SearchResource.new(search_query, context))
    end
  end
end
