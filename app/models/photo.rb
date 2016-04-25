class Photo < ApplicationRecord
  belongs_to :user
  belongs_to :album

  enum cover: %w(album)

  validates :album_id, presence: true
end

# == Schema Information
#
# Table name: photos
#
#  id         :uuid             not null, primary key
#  caption    :string
#  user_id    :uuid
#  album_id   :uuid
#  cover      :integer          default("album")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_photos_on_album_id  (album_id)
#  index_photos_on_user_id   (user_id)
#
# Foreign Keys
#
#  fk_rails_c79d76afc0  (user_id => users.id)
#
