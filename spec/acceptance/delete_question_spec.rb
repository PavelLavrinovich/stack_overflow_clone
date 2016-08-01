require_relative 'acceptance_helper'

feature 'User deletes his question.', %q{
  In order to cover my shame
  As an author of question
  I want be able to delete my questions
} do

  given(:question) { create(:question) }
  given(:another_user) { create(:user) }

  scenario 'Authenticated user tries to delete his question' do
    sign_in(question.user)

    visit question_path(question)
    click_on 'Delete the question'

    expect(current_path).to eq questions_path
    expect(page).to_not have_content question.title
  end

  scenario "Authenticated user tries to delete another author's question" do
    sign_in(another_user)

    visit question_path(question)

    expect(page).to_not have_content 'Delete the question'
  end

  scenario 'Non-authenticated user tries to delete a question' do
    visit question_path(question)

    expect(page).to_not have_content 'Delete the question'
  end
end