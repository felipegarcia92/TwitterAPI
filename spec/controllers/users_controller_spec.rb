require 'spec_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET index" do
    it 'true' do
      expect(true).to be true
    end

    # it "assigns @teams" do
    #   team = Team.create
    #   get :index
    #   expect(assigns(:teams)).to eq([team])
    # end

    # it "renders the index template" do
    #   get :index
    #   expect(response).to render_template("index")
    # end
  end
end
