require "spec_helper"

describe UserLikeTweet, type: :model do

  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:tweet_id) }

  it { should belong_to(:tweet) }
  it { should belong_to(:user) }

  it "has a valid factory" do
    expect(FactoryGirl.build(:user_like_tweet).valid?).to be true
  end

  it "has correct relations with user and tweet" do
    expect(FactoryGirl.build(:user_like_tweet).user.valid?).to be true
    expect(FactoryGirl.build(:user_like_tweet).tweet.valid?).to be true
  end
end
