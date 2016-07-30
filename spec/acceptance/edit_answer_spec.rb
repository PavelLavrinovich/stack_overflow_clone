require_relative 'acceptance_helper'

feature 'User edits the answer', %q{
  In order to make the answer even better
  As an author of the answer
  In want to be able to edit my answer
} do

  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:question) { create(:question) }
  given(:answer) { create(:answer, question: question, user: user) }

  describe 'Authenticated user' do
    background do
      answer
    end

    scenario 'tries to edit his answer', js: true do
      sign_in(user)

      visit question_path(question)
      click_on 'Edit the answer'

      within '.answers' do
        fill_in 'Your answer', with: 'new_answer'
        click_on 'Confirm'
      end

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