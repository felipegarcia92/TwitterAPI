require "faker"

FactoryGirl.define do
  factory :user do |u|
    u.first_name { Faker::Name.first_name }
    u.last_name { Faker::Name.last_name }
    u.email { Faker::Internet.email }
    u.password { Faker::Internet.password(8) }
  end
end
