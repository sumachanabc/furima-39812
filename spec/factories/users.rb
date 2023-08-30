FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    email                 { Faker::Internet.email }
    password              { 'a1' + Faker::Internet.password(min_length: 4, max_length: 128) }
    password_confirmation { password }
    date_of_birth         { Faker::Date.between(from: Date.new(1930, 1, 1), to: Date.new(2018, 12, 31)) }
    first_name            { '太郎' }
    family_name           { '田中' }
    read_first_name       { 'タロウ' }
    read_family_name      { 'タナカ' }
  end
end
