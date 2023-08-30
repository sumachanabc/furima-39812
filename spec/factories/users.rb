FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    date_of_birth         { Faker::Date.between(from: 80.years.ago, to: 5.years.ago) }
    first_name            { Faker::Japanese::Name.first_name }
    family_name           { Faker::Japanese::Name.last_name }
    read_first_name       { Faker::Japanese::Name.first_name.yomi }
    read_family_name      { Faker::Japanese::Name.last_name.yomi }
  end
end