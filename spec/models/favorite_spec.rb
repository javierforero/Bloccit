require 'rails_helper'

RSpec.describe Favorite, type: :model do

  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }
  let(:favorite) { Favorite.create!(post: post, user: user) }

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }

  include SessionsHelper

  RSpec.describe FavoritesController, type: :controller do
    let(:my_user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
    let(:my_topic) { Topic.create!(name:  RandomData.random_sentence, description: RandomData.random_paragraph) }
    let(:my_post) { my_topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: my_user) }

    context 'guest user' do
      describe 'POST create' do
        it 'redirects the user to the sign in view' do
          post :create, { post_id: my_post.id }
          expect(response).to redirect_to(new_session_path)
        end
      end
    end

    context 'signed in user' do
      before do
        create_session(my_user)
      end

      describe 'POST create' do
        it 'redirects to the posts show view' do
          post :create, { post_id: my_post.id }
          expect(response).to redirect_to([my_topic, my_post])
        end

        it 'creates a favorite for the current user and specified post' do
          expect(my_user.favorites.find_by_post_id(my_post.id)).to be_nil

          post :create, { post_id: my_post.id }

          expect(my_user.favorites.find_by_post_id(my_post.id)).not_to be_nil
        end
      end
    end
end
