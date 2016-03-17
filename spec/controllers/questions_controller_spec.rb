require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
 let(:my_question){Question.create!(title: RandomData.random_sentence , body: RandomData.random_paragraph ,resolved: false)}
  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

   it "assigns question" do
     get :index
     expect(assigns(:questions)).to eq([my_question])
   end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders new view" do
      get :new
      expect(response).to render_template :new
    end

    it "test that it instantiates questions" do
      get :new
      expect(assigns(:question)).not_to be_nil
    end
  end

  describe "GET #create" do

    it "it increases the count of questions by 1" do
      expect{post :create, question: {title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: false}}.to change(Question,:count).by(1)
    end

    it "assigns the new question to @question" do
      post :create, question: {title: RandomData.random_sentence, body: RandomData.random_paragraph, resolved: false}
      expect(assigns(:question)).to eq Question.last
    end

    it "redirects to the new post" do
      post :create, question: {title: RandomData.random_sentence, body: RandomData.random_paragraph, resolve: false}
      expect(response).to redirect_to Question.last
    end

  end

  describe "GET #show" do
    it "returns http success" do
      get :show, {id: my_question.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit , {id: my_question.id}
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #update" do
    it "updates question with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_resolved = false

      put :update, id: my_question.id, question: {title: new_title, body: new_body, resolved: new_resolved}

      updated_question = assigns(:question)
      expect(updated_question.id).to eq my_question.id
      expect(updated_question.title).to eq new_title
      expect(updated_question.body).to eq new_body
      expect(updated_question.resolved).to eq new_resolved

    end

    it "redirects to the updated question" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph
      new_resolved = false

      put :update, id: my_question.id, question: {title: new_title, body: new_body, resolved: new_resolved}
      expect(response).to redirect_to my_question
    end
  end

  describe "GET #destroy" do

    it "deletes the question" do
      delete :destroy, {id: my_question.id}

      count = Question.where({id: my_question.id}).size
      expect(count).to eq 0
    end

    it "redirect to posts index" do
      delete :destroy, {id: my_question.id}

      expect(response).to redirect_to questions_path
    end
  end

end
