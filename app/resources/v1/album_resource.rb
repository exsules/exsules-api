module V1
  class AlbumResource < BaseResource
    attributes :id

    has_one :owner, polymorphic: true
  end
end
