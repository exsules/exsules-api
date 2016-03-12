module V1
  class SearchesController < ApplicationController
    before_action :authenticate_user!

    def index
      search_query = User.search(params[:q], {
        fields: ["first_name", "last_name", "username"],
        limit: 10
      })

      render json: serialize_models(search_query, {serializer: SearchSerializer})
    end
  end
end
