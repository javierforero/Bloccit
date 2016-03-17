require 'rails_helper'

RSpec.describe TopicsController, type: :controller do
  let(:my_topic) {Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)}

  describe "GET index" do

     it "returns http sucess" do
       get :index
       expect(response).to have_http_status(:success)
     end

     it "assings my_topic to @topics" do
       get :index
       expect(assigns(:topics)).to eq ([my_topic])
     end
  end
end
