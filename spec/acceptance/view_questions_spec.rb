require 'acceptance/acceptance_helper'

feature 'User views questions', %q{
  In order to find interesting questions
  As an user
  I want to be able to view questions
} do
  let(:questions) { create_list(:question, 2) }
  before { questions }

  scenario 'User tries to view questions' do
    visit questions_path
    expect(page).to have_content questions.first.title
    expect(page).to have_content questions.last.title
  end
end