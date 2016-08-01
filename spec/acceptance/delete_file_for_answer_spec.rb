require_relative 'acceptance_helper'

feature 'User can delete files for his answer', %q{
  In order to delete a wrong example
  As an author
  I want to be able to delete files for my answer
} do

  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given(:question) { create(:question, user: user) }
  given(:answer) { create(:answer, question: question, user: user) }
  given(:attachment) { create(:attachment, attachable: answer) }

  describe 'Authenticated user' do
    scenario 'tries to delete files for his answer', js: true do
      sign_in(user)
      attachment
      visit question_path(question)

      within '.answer' do
        within '.attachments' do
          click_on 'Delete the file'
        end
      end

      expect(page).to_not have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end

    scenario "tries to delete files for another user's answer", js: true do
      sign_in(another_user)
      attachment
      visit question_path(question)

      within '.answer' do
        within '.attachments' do
          expect(page).to_not have_content 'Delete the file'
        end
      end
    end
  end

  scenario 'Unauthenticated user tries to delete a file for the answer', js: true do
    attachment
    visit question_path(question)

    within '.answer' do
      within '.attachments' do
        expect(page).to_not have_content 'Delete the file'
      end
    end
  end

end