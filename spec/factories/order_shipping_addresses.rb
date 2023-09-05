FactoryBot.define do
  factory :order_shipping_address do
    association :user
    association :item

    postal_code    { '123-4567' }
    prefecture_id  { 2 }
    city           { '東京都' }
    street_address { '1-1' }
    building_name  { '東京ハイツ' }
    phone_number   { '1234567890' }# { Faker::PhoneNumber.subscriber_number(number: 10..11) }
    token { 'your_token_value_here' }
  end
end