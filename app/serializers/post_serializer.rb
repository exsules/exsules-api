class PostSerializer < BaseSerializer
  attributes :message,
             :user_id,
             :from_user_id,
             :comments_count,
             :likes_count,
             :reposts_count,
             :created_at,
             :updated_at

  has_one :user
  has_one :link_crawler_cache

  attribute :author do
    "#{object.source.first_name} #{object.source.last_name}"
  end

  attribute :username do
    "#{object.source.username}"
  end
end
