require 'acceptance/acceptance_helper'

feature 'User edits the answer', %q{
  In order to make the answer even better
  As an author
  In want to be able to edit my answer
} do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }
  let(:question) { create(:question) }
  let(:answer) { create(:answer, question: question, user: user) }

  describe 'Authenticated user' do
    before do
      answer
    end

    scenario 'tries to edit his answer', js: true do
      sign_in(user)
      visit question_path(question)
      click_on 'Edit the answer'
      save_and_open_page
      fill_in 'Your answer', with: 'new_answer'
      click_on 'Confirm'

      expect(page).to have_content 'new_answer'
      expect(page).to_not have_content answer.body
    end

    scenario "tries to edit another user's answer" do
      sign_in(another_user)
      visit question_path(question)
      expect(page).to_not have_link 'Edit the answer'
    end
  end

  scenario 'Unauthenticated user tries to edit the answer' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit the answer'
  end
end