FactoryGirl.define do
  factory :bid do
    price { Faker::Number.number(2)}
    user nil
    auction nil
  end
end
