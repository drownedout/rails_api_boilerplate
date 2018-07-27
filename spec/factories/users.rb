FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    email 'test@test.com'
    password 'password'
  end
end