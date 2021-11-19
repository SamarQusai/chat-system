FactoryBot.define do
  factory :chat do
    application
    sequential_number { Faker::Number.between(from: 1, to: 100) }
  end
end