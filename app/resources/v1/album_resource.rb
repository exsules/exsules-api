module V1
  class AlbumResource < BaseResource
    attributes :name

    has_one :owner, polymorphic: true
  end
end
