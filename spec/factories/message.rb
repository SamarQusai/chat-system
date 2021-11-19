FactoryBot.define do
  factory :message do
    chat
    sequential_number { Faker::Number.between(from: 1, to: 100) }
    body  { Faker::Lorem.word }
  end
end