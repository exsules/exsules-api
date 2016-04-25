class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likable, polymorphic: true, counter_cache: :likes_count

  validates :user, presence: true, uniqueness: { scope: :likable_id }
end

# == Schema Information
#
# Table name: likes
#
#  id           :uuid             not null, primary key
#  user_id      :uuid
#  likable_type :string
#  likable_id   :uuid
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_likes_on_likable_type_and_likable_id  (likable_type,likable_id)
#  index_likes_on_user_id                      (user_id)
#
# Foreign Keys
#
#  fk_rails_1e09b5dabf  (user_id => users.id)
#
