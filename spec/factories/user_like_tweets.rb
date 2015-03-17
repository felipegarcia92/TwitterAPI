FactoryGirl.define do
  factory :user_like_tweet do
    #Create both an user and a tweet to set relation
    association :user
    association :tweet
  end
end
