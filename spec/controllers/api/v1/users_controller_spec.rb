require 'spec_helper'

RSpec.describe Api::V1::UsersController, type: :controller do

  describe "GET show" do
    it 'gets a user' do
      user = FactoryGirl.create(:user)

      get :show, id: user.id, token: user.session_token

      expect(response).to be_success # test for the 200 status-code
      json = JSON.parse(response.body)
      expect(json['first_name']).to eq(user.first_name) # check to make sure the name is the same
      expect(json['id']).to eq(user.id) # check to make sure the id is the same
    end

    it 'returns authentication exception' do
      user = FactoryGirl.create(:user)

      get :show, id: user.id, token: "fake"

      expect(response.status).to eq(401)
      expect(response.body).to eq("401 Authenticate Exception") # check to make sure the plain message is the same
    end
  end

end
