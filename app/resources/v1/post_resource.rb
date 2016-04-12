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
    has_many :comments
    has_many :likes

    def author
      "#{@model.source.first_name} #{@model.source.last_name}"
    end

    def username
      @model.source.username
    end

    class << self
      def creatable_fields(context)
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

      def updatable_fields(context)
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
    end
  end
end
