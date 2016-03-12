class UserSerializer < BaseSerializer
  attributes :first_name,
             :last_name,
             :username,
             :location,
             :sex,
             :birthday,
             :role,
             :password,
             :slug

  has_many :posts
  has_many :albums, as: :owner

end
