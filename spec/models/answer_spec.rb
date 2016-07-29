require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should validate_presence_of :body }
  it { should validate_presence_of :question_id }
  it { should belong_to :question }
  it { should belong_to :user }

  let(:answers) { create_list(:answer, 5) }
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }
  let(:old_answer) { create(:answer, question: question) }

  describe 'choose the best' do
    it 'sets the answer to the best answer' do
      answer.choose_the_best
      expect(answer.best).to eq true
    end

    it 'sets the old answer to not the best anymore' do
      old_answer.choose_the_best
      answer.choose_the_best
      old_answer.reload
      expect(old_answer.best).to eq false
    end
  end
end
