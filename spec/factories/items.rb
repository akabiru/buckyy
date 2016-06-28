FactoryGirl.define do
  factory :item do
    name { Faker::StarWars.character }
    done false
    bucketlist_id nil
  end
end
