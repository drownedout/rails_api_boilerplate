FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    email 'foo@bar.com'
    password 'foobar'
  end
end