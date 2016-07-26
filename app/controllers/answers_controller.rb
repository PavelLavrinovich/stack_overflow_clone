class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_answer, only: [:update, :destroy]

  def create
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @answer.user = current_user
    @answer.save
    respond_to { |format| format.js }
  end

  def update
    @answer.update(answer_params) if current_user.author?(@answer)
    respond_to { |format| format.js }
  end

  def destroy
    @answer.destroy if current_user.author?(@answer)
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:body)
  end
end
