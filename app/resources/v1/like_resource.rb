module V1
  class LikeResource < BaseResource
    attributes :liker

    has_one :user

    def liker
      "#{@model.user.first_name}"
    end
  end
end
