require 'rails_helper'

feature 'User views questions', %q{
  In order to find interesting questions
  As an user
  I want to be able to view questions
} do
  before { create_list(:question, 2) }

  scenario 'User tries to view questions' do
    visit questions_path
    expect(page).to have_content('GreatTitle№1')
    expect(page).to have_content('GreatTitle№2')
  end
end