FactoryBot.define do
  factory :donation_address do
    postal_code { '123-4567' }
    prefecture { 2 }
    city { '東京都' }
    house_number { '1-1' }
    building_name { '東京ハイツ' }
    phone_number { Faker::PhoneNumber.subscriber_number(length: 10..11) }
  end
end