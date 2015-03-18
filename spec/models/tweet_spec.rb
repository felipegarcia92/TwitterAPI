describe Tweet, type: :model do
  it { should validate_presence_of(:text) }
  it { should belong_to(:user) }
  it { should have_many(:user_like_tweets) }

  it "has a user" do
    expect(FactoryGirl.build(:tweet).user.valid?).to be true
  end

end
