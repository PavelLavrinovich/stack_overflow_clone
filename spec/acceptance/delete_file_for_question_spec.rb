require_relative 'acceptance_helper'

feature 'User can delete files for his question', %q{
  In order to delete a wrong example
  As an author
  I want to be able to delete files for my question
} do

  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:attachment) { create(:attachment, attachable: question) }

  describe 'Authenticated user' do
    scenario 'tries to delete files for his question', js: true do
      sign_in(user)
      attachment
      visit question_path(question)

      within '.attachments' do
        click_on 'Delete the file'
      end

      expect(page).to_not have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end

    scenario "tries to delete files for another user's question", js: true do
      sign_in(another_user)
      attachment
      visit question_path(question)

      within '.attachments' do
        expect(page).to_not have_content 'Delete the file'
      end
    end
  end

  scenario 'Unauthenticated user tries to delete a file for the question', js: true do
    attachment
    visit question_path(question)

    within '.attachments' do
      expect(page).to_not have_content 'Delete the file'
    end
  end

end