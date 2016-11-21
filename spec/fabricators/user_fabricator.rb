Fabricator(:user) do
  username { Faker::Internet.user_name}
  email { Faker::Internet.email}
  about { Faker::Lorem.sentences(1).first }
  password { Faker::Lorem.word }
end