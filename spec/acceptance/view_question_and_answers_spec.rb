require 'rails_helper'

feature 'User views a questions with answers', %q{
  In order to read something interesting
  As an user
  I want to be able to view a question with answers
} do
  let(:question) { create(:question) }
  let(:answer) { create(:answer) }

  scenario 'User tries to view question with answer' do
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    expect(page).to have_content answer.body
  end
end