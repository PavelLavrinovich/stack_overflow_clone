require 'rails_helper'

feature 'User creates an answer', %q{
  In order to help someone and prove my humanity
  As an authenticated user
  I want to be able to give an answer
} do

  let(:user) { create(:user) }
  let(:question) { create(:question) }

  scenario 'Authenticated user tries to give an answer' do
    sign_in(user)

    visit question_path(question)
    fill_in 'Body', with: 'some_answer'
    click_on 'Create'

    expect(page).to have_content 'some_answer'
    expect(current_path).to eq question_path(question)
  end

  scenario 'Non-authenticated user tries to give an answer' do
    visit question_path(question)
    click_on 'Create'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end