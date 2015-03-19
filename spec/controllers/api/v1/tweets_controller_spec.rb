require 'spec_helper'

RSpec.describe Api::V1::TweetsController, type: :controller do

  describe "GET show" do
    it 'gets a tweet' do
      tweet = FactoryGirl.create(:tweet)
      user = FactoryGirl.create(:user)

      get :show, id: tweet.id, token: user.session_token

      expect(response).to be_success # test for the 200 status-code
      json = JSON.parse(response.body)
      expect(json['text']).to eq(tweet.text) # check to make sure the name is the same
      expect(json['id']).to eq(tweet.id) # check to make sure the id is the same
    end

    it 'returns authentication exception' do
      tweet = FactoryGirl.create(:tweet)

      get :show, id: tweet.id, token: "fake"

      expect(response.status).to eq(401)
      expect(response.body).to eq("401 Authenticate Exception") # check to make sure the plain message is the same
    end
  end

  describe "POST create" do
    it "creates a valid tweet" do
      user = FactoryGirl.create(:user)

      post :create, tweet: { user_id: user.id, text: "Test tweet here!" }, token: user.session_token

      json = JSON.parse(response.body)
      expect(json['text']).to eq("Test tweet here!") # check to make sure the name is the same
      expect(json['id']).to eq(user.id) # check to make sure the id is the same
    end

    it "throws exception if not valid" do
      user = FactoryGirl.create(:user)

      post :create, testfail: { user_id: user.id, text: "Test tweet here!" }, token: user.session_token

      expect(response.status).to eq(422)
      expect(response.body).to eq("422 Parameter Missing") # check to make sure the plain message is the same
    end
  end

  describe "PUT update" do
    it "updates properly" do
      user = FactoryGirl.create(:user)
      tweet = FactoryGirl.create(:tweet)

      patch :update, id: tweet.id, tweet: { user_id: tweet.user_id, text: "Tweet updated!" }, token: user.session_token

      json = JSON.parse(response.body)
      tweet.reload
      expect(tweet.text).to eq("Tweet updated!") # check to make sure the text is updated
    end
  end

  describe "DELETE destroy" do
    it "deletes properly" do
      user = FactoryGirl.create(:user)
      tweet = FactoryGirl.create(:tweet)

      delete :destroy, id: tweet.id, token: user.session_token

      expect(response.status).to eq(204)
    end
  end

  describe "POST like" do
    it "likes a tweet" do
      user = FactoryGirl.create(:user)
      tweet = FactoryGirl.create(:tweet)

      post :like, tweet_id: tweet.id, token: user.session_token

      expect(UserLikeTweet.find_by(tweet_id: tweet.id, user_id: user.id).present?).to be true
    end
  end

  describe "DELETE like" do
    it "dislikes a tweet" do
      user = FactoryGirl.create(:user)
      tweet = FactoryGirl.create(:tweet)

      post :like, tweet_id: tweet.id, token: user.session_token
      delete :dislike, tweet_id: tweet.id, token: user.session_token

      expect(UserLikeTweet.find_by(tweet_id: tweet.id, user_id: user.id).present?).to be false
    end
  end
end
