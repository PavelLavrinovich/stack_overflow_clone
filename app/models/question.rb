class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :user
  belongs_to :best_answer, class_name: 'Answer', foreign_key: :best_answer_id

  validates :title, :body, :user_id, presence: true

  def choose_the_best(answer)
    self.best_answer = answer
  end

  def answers_from_the_best
    answers.where('id <> ?', best_answer_id).to_a.unshift(best_answer)
  end
end
