FactoryBot.define do
  factory :application do
    name {Faker::Name.name}
  end
end