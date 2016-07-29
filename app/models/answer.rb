class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  validates :body, :question_id, :user_id, presence: true

  scope :from_the_best, -> { order('best DESC') }

  def choose_the_best
    unless best
      question.answers.where(best: true).update_all(best: false)
      update best: true
    end
  end
end
