module V1
  class SearchesController < ApplicationController

    def index
      #query_param = User.search(params[:q], {
        #fields: ["first_name", "last_name"],
        #limit: 10
      #})
      #query_param = User.search params[:q], fields: ["first_name", "last_name"]
      query_param = User.search params[:q]#, fields: ["first_name", "last_name"]

      query_param.collect do |u|
        json =  JSONAPI::ResourceSerializer.
          new(V1::SearchResource).
          serialize_to_hash(V1::SearchResource.new(
            u, nil
          ))
        render json: json
      end
    end
  end
end
