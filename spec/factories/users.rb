FactoryGirl.define do
  factory :user do
    firstname { Faker::Name.first_name }
    lastname { Faker::Name::last_name }
    email 'me@andela.com'
    password 'foobar'
  end
end
