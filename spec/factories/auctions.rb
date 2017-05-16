FactoryGirl.define do
  factory :auction do
    sequence(:title) {|t| "Cool idea title #{t}"}
    details "Description of the idea"
    ends_on {Faker::Date.forward(23)}
    reserve_price { Faker::Number.number(2)}
    user nil

  end
end
