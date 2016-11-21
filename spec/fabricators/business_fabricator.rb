Fabricator(:business) do
  name { Faker::Company.name}
  city { Faker::Address.city }
  description { Faker::Company.catch_phrase }
end