require "faker"

FactoryGirl.define do
  factory :tweet do
    text { Faker::Lorem.characters(10) }
    user
  end

end
