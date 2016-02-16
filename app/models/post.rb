class Post < ApplicationRecord
  belongs_to :user
  belongs_to :source, class_name: 'User', foreign_key: :from_user_id

  validates :message, presence: true

  def raw_message
    self[:message]
  end

  def urls
    @urls ||= Twitter::Extractor.extract_urls(raw_message)
  end
end

# == Schema Information
#
# Table name: posts
#
#  id             :uuid             not null, primary key
#  user_id        :uuid
#  message        :text
#  likes_count    :integer          default(0)
#  comments_count :integer          default(0)
#  from_user_id   :uuid
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  reposts_count  :integer          default(0)
#
# Indexes
#
#  index_posts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_5b5ddfd518  (user_id => users.id)
#
