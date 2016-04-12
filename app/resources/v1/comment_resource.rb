module V1
  class CommentResource < BaseResource
    attributes :author,
               :text,
               :likes_count,
               :created_at,
               :updated_at

    has_one :user
    has_many :likes

    def author
      "#{@model.user.first_name} #{@model.user.last_name}"
    end

    class << self
      def creatable_fields(context)
        super - [
          :author,
          :created_at,
          :updated_at,
          :likes_count
        ]
      end

      def updatable_fields(context)
        super - [
          :author,
          :created_at,
          :updated_at,
          :likes_count
        ]
      end
    end

  end
end
