require_relative 'acceptance_helper'

feature 'User edits the question', %q{
  In order to make the question even better
  As an author of the question
  In want to be able to edit my question
} do

  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:question) { create(:question, user: user) }

  describe 'Authenticated user' do
    scenario 'tries to edit his question', js: true do
      sign_in(user)

      visit question_path(question)
      click_on 'Edit the question'

      within '.question' do
        fill_in 'Title', with: 'new_title'
        fill_in 'Body', with: 'new_body'
        click_on 'Confirm'
      end

      expect(page).to have_content 'new_title'
      expect(page).to have_content 'new_body'
      expect(page).to_not have_content question.title
      expect(page).to_not have_content question.body
    end

    scenario "tries to edit another user's question" do
      sign_in(another_user)
      visit question_path(question)
      expect(page).to_not have_link 'Edit the question'
    end
  end

  scenario 'Unauthenticated user tries to edit the question' do
    visit question_path(question)

    expect(page).to_not have_link 'Edit the question'
  end
end