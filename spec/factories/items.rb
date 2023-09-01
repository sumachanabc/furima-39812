# spec/factories/items.rb
FactoryBot.define do
  factory :item do
    association :user
    association :category
    association :condition
    association :shipping_detail
    association :prefecture
    association :shipping_timeframe
    item_name             { Faker::Commerce.product_name }
    description           { Faker::Lorem.paragraph }
    price                 { Faker::Number.between(from: 300, to: 9_999_999) }
    image                 { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/タスク着手順序.png'), 'image/png') }
  end
end
