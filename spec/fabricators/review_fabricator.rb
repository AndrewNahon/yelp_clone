Fabricator(:review) do 
  user 
  business
  body { Faker::Lorem.paragraphs(2).join }
  rating { [1, 2, 3, 4, 5].sample }
end