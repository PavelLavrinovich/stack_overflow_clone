require_relative 'acceptance_helper'

feature 'User creates a question', %q{
  In order to find an answer
  As an authenticated user
  I want to be able to create question
} do

  given(:user){ create(:user) }

  scenario 'Authenticated user tries to create a question' do
    sign_in(user)

    visit questions_path
    click_on 'Ask a question'
    fill_in 'Title', with: 'some_title'
    fill_in 'Body', with: 'some_body'
    click_on 'Confirm'

    expect(page).to have_content 'Your question was successfully created.'
    expect(page).to have_content 'some_title'
    expect(page).to have_content 'some_body'
  end

  scenario 'Non-authenticated user tries to create a question' do
    visit questions_path
    click_on 'Ask a question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end