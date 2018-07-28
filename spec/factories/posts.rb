FactoryBot.define do
  factory :post do
    content { Faker::Lorem.word }
    user_id { Faker::Number.number(3) }
  end	
end
