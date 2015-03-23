require "spec_helper"
require 'digest/sha1'

describe User do

  it "has a valid factory" do
    expect(FactoryGirl.create(:user)).to be_truthy
  end

  #Tests presence of mandatory fields
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:email) }

  it { should have_many(:tweets) }

  it "has a valid email" do
    expect(FactoryGirl.build(:user, email: "failedtest").valid?).to be false
    expect(FactoryGirl.build(:user, email: "pass@test.com").valid?).to be true
  end

  it "has a 6-length password at least" do
    expect(FactoryGirl.build(:user, password: "5char").valid?).to be false
    expect(FactoryGirl.build(:user, password: "morethansixchar").valid?).to be true
  end

  it "has unique emails" do
    expect(FactoryGirl.create(:user, email: "notunique@test.com").valid?).to be true
    expect(FactoryGirl.build(:user, email: "notunique@test.com").valid?).to be false
  end

  it "has a correct password callback" do
    expect(FactoryGirl.create(:user, password: "morethansixchar").encrypted_password).to eq(Digest::SHA1.hexdigest("morethansixchar"))
  end
end
