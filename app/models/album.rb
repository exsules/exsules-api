class Album < ApplicationRecord
  belongs_to :owner, polymorphic: true
  has_many :photos, dependent: :destroy

  enum status: %w(open closed hidden)

end

# == Schema Information
#
# Table name: albums
#
#  id         :uuid             not null, primary key
#  name       :string
#  owner_type :string
#  owner_id   :uuid
#  status     :integer          default("open"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_albums_on_owner_type_and_owner_id  (owner_type,owner_id)
#
