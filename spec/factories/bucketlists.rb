FactoryGirl.define do
  factory :bucketlist do
    name { Faker::Lorem.word }
    created_by { Faker::StarWars.character }
  end
end
