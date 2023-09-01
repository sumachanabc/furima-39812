FactoryBot.define do
  factory :item do
    association :user

    item_name             { Faker::Commerce.product_name }
    description           { Faker::Lorem.sentence }
    category_id           { 2 }
    condition_id          { 2 }
    shipping_detail_id    { 2 }
    prefecture_id         { 2 }
    shipping_timeframe_id { 2 }
    price                 { Faker::Number.within(range: 300..9_999_999) }
    image                 { Rack::Test::UploadedFile.new(Rails.root.join('spec/fixtures/タスク着手順序.png'), 'image/png') }
  end
end
