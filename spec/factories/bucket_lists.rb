FactoryGirl.define do
  factory :bucket_list do
    name { Faker::Lorem.word }
    created_by { Faker::StarWars.character }
  end
end
