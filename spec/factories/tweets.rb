require "faker"

FactoryGirl.define do
  factory :tweet do
    text { Faker::Lorem.characters(30) }
    user
  end

end
