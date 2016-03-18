class QuestionsController < ApplicationController
  def index
    @questions = Question.all
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new
    @question.title = params[:question][:title]
    @question.body = params[:question][:body]
    @question.resolved = params[:question][:resolved]

    if @question.save
      flash[:notice] = "Question Successfully created..."
      redirect_to @question
    else
      flash[:alert] = "There was an error creating your question. Please try again."
      render :new
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.title = params[:question][:title]
    @question.body = params[:question][:body]
    @question.resolved = params[:question][:resolved]

    if @question.save
      flash[:notice] = "Question successfully updated..."
      redirect_to @question
    else
      flash[:alert] = "There was a problem updating. PLease try again..."
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])

    if @question.destroy
      flash[:notice] = "Question #{@question.title} was deleted"
      redirect_to questions_path
    else
      flash[:alert] = "Unable to delete question"
      render :show
    end
  end
end
