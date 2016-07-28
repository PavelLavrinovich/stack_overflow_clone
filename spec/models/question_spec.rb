require 'rails_helper'

RSpec.describe Question, type: :model do
  it { should validate_presence_of :title }
  it { should validate_presence_of :body }
  it { should have_many(:answers).dependent(:destroy) }
  it { should belong_to :user }

  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }
  let(:answers) { create_list(:answer, 5) }

  describe 'choose the best' do
    it 'sets the answer to the best answer' do
      question.choose_the_best(answer)
      expect(question.best_answer).to eq answer
    end
  end

  describe 'answers from the best' do
    it 'returns ordered answers (the best is the first)' do
      question.answers = answers
      question.choose_the_best(answers.last)
      expect(question.answers_from_the_best.first).to eq answers.last
    end
  end
end
