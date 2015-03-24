require 'spec_helper'
require 'digest/sha1'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe "POST login" do
    it "logs in correctly" do
      user = FactoryGirl.create(:user, password: "pass1234")

      post :login, email: user.email, password: user.password

      expect(response.status).to eq(200)
    end

    it "returns error if the password is incorrect" do
      user = FactoryGirl.create(:user, password: "pass1234")

      post :login, email: user.email, password: "fail.password"

      expect(response.status).to eq(401)
    end

    it "returns error if the email is incorrect" do
      user = FactoryGirl.create(:user, password: "pass1234")

      post :login, email: "felipe@toptierlabs.com", password: "pass1234"

      expect(response.status).to eq(401)
    end
  end
end
