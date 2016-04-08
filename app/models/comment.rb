class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, polymorphic: true, counter_cache: :comments_count

  validates :text, presence: true

  #after_commit :update_counters, on: :create

  acts_as_taggable_on :tags
end

# == Schema Information
#
# Table name: comments
#
#  id               :uuid             not null, primary key
#  text             :string           not null
#  user_id          :uuid
#  likes_count      :integer          default(0)
#  commentable_type :string           default("Post")
#  commentable_id   :uuid
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_comments_on_commentable_type_and_commentable_id  (commentable_type,commentable_id)
#  index_comments_on_user_id                              (user_id)
#
# Foreign Keys
#
#  fk_rails_03de2dc08c  (user_id => users.id)
#
