require_relative 'acceptance_helper'

feature 'User chooses some answer the best for his question', %q{
  In order to honor the person, who gave great answer
  As an author of question
  I want be able to choose the answer the best
} do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answers) { create(:answer, 10, question: question) }

  describe 'Authenticated user' do
    before { sign_in(user) }

    scenario 'tries to choose some answer the best for his question' do
      visit question_path(question)

      find("##{dom_id(answers.last)}").click 'Make this answer the best'

      expect(dom_id(answers.last)).to gt dom_id(answers.first)
    end

    scenario "tries to choose some answer the best for another person's question" do
      visit question_path(question)

      expect(page).to_not have_content 'Make this answer the best'
    end
  end

  scenario 'Unauthenticated user tries to choose some answer the best' do
    visit question_path(question)

    expect(page).to_not have_content 'Make this answer the best'
  end
end
