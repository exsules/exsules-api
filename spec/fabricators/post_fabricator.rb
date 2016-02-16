Fabricator(:post) do
  message { Faker::Lorem.sentences }

  user
  source(fabricator: :user)
end
