require 'rails_helper'

RSpec.describe Api::V1::CommentsController, type: :controller do
  let(:my_topic) { create(:topic)}
  let(:my_user) { create(:user) }
  let(:my_post) { create(:post, user: my_user, topic: my_topic) }
  let(:my_comment) { my_post.comments.create!(body: RandomData.random_paragraph, user: my_user)}

  context "unauthenticated user" do
    it "GET index returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "GET show returns http success" do
      get :show, id: my_comment.id
      expect(response).to have_http_status(:success)
    end

    it "returns array of comments" do
      get :show, id: my_comment.id
      comments_hash = JSON.parse  response.body
      expect(comments_hash['id']).to eq my_comment.id
      expect(comments_hash['body']).to eq my_comment.body
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
      get :show, id: my_comment.id
      expect(response).to have_http_status(:success)
    end
  end
end
