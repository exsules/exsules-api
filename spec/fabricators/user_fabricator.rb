Fabricator(:user) do
  email { Faker::Internet.email }
  username { Faker::Internet.user_name.tr('.', '-') }
  password { SecureRandom.hex }
  first_name  { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  language { %w(en sv no).sample }
  sex { [0, 1, 2].sample }
end
