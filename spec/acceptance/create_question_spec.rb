require 'rails_helper'

feature 'User creates a question', %q{
  In order to find an answer
  As an authenticated user
  I want to be able to create question
} do
  scenario 'Authenticated user tries to create a question' do
    User.create(email: 'email@example.com', password: 'password')

    visit new_user_session_path
    fill_in 'Email', with: 'email@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'

    visit questions_path
    click_on 'Ask a question'
    fill_in 'Title', with: 'some_title'
    fill_in 'Body', with: 'some_body'
    click_on 'Ask'

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