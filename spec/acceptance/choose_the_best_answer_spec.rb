require_relative 'acceptance_helper'

feature 'User chooses some answer the best for his question', %q{
  In order to honor the person, who gave great answer
  As an author of question
  I want be able to choose the answer the best
} do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }
  let(:answers) { create_list(:answer, 10) }

  describe 'Authenticated user' do
    before { sign_in(user) }

    scenario 'tries to choose some answer the best for his question', js: true do
      question.answers = answers
      visit question_path(question)

      all('.choose_the_best').last.click

      wait_for_ajax

      expect(all('.answer').first).to have_content answers.last.body
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
