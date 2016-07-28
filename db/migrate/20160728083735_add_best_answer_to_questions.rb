class AddBestAnswerToQuestions < ActiveRecord::Migration
  def change
    add_belongs_to :questions, :best_answer, index: true
  end
end
