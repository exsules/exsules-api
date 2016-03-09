module V1
  class PostResource < BaseResource
    attributes :author,
               :message,
               :username,
               :user_id,
               :from_user_id,
               :comments_count,
               :likes_count,
               :reposts_count,
               :created_at,
               :updated_at

    has_one :user

    def author
      "#{@model.source.first_name} #{@model.source.last_name}"
    end

    def username
      @model.source.username
    end

    def self.creatable_fields(context)
      super - [
        :author,
        :username,
        :created_at,
        :updated_at,
        :reposts_count,
        :likes_count,
        :comments_count
      ]
    end

    def self.updatable_fields(context)
      super - [
        :author,
        :username
      ]
    end

  end
end
