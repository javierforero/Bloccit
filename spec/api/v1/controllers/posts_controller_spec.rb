require 'rails_helper'

RSpec.describe Api::V1::PostsController, type: :controller do
  let(:my_topic) { create(:topic)}
  let(:my_user) { create(:user) }
  let(:my_post) { create(:post, user: my_user, topic: my_topic) }
  let!(:my_comment) { my_post.comments.create!(body: RandomData.random_paragraph, user: my_user)}
  
  context "unauthenticated user" do
    it "GET index returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "GET show returns http success" do
      get :show, id: my_post.id
      expect(response).to have_http_status(:success)
    end

    it "returns child comments" do
      get :show, id: my_post.id
      post_hash = JSON.parse response.body
      array_of_comment_hashes = post_hash['comments']
      expect(array_of_comment_hashes).to_not be_nil
      expect(array_of_comment_hashes.first['id']).to eq(my_comment.id)

    end

  end

  context "unauthorized user" do
    before do
      controller.request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Token.encode_credentials(my_user.auth_token)
    end

    it "GET index returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "GET show returns http success" do
      get :show, id: my_post.id
      expect(response).to have_http_status(:success)
    end
  end
end
