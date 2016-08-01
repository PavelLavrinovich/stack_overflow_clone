class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :attachments, as: :attachable, dependent: :destroy

  validates :body, :question_id, :user_id, presence: true

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  scope :from_the_best, -> { order('best DESC') }

  def choose_the_best
    unless best
      Answer.transaction do
        question.answers.where(best: true).update_all(best: false)
        update best: true
      end
    end
  end
end
