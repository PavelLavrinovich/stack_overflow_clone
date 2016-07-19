require 'rails_helper'

feature 'User sign in', %q{
  In order to create questions
  As an user
  I want to sign in
} do
  scenario 'Registered user try to sign in' do
    User.create(email: 'email@example.com', password: 'password')

    visit new_user_session_path
    fill_in 'Email', with: 'email@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'

    expect(page).to have_content 'Invalid Email or password.'
  end
end