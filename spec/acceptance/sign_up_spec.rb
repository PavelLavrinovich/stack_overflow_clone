require 'acceptance/acceptance_helper'

feature 'User signs up', %q{
  In order to create questions and answers
  As an user
  I want to be able to sign up
} do
  scenario 'User tries to sign up' do
    visit new_user_registration_path

    fill_in 'Email', with: 'example@email.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'

    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end