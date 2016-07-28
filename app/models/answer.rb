class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_one :question_as_the_best, class_name: 'Question', foreign_key: :best_answer_id

  validates :body, :question_id, :user_id, presence: true
end
