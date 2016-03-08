module V1
  class AlbumsController < ApplicationController
    before_action :authenticate_user!
  end
end
