class AnswersController < ApplicationController
  before_action :authenticate_user!

  def new
    @answer = Answer.new
  end

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.save ? redirect_to(@question) : render(:new)
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
