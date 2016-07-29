require_relative 'acceptance_helper'

feature 'User views a questions with answers', %q{
  In order to read something interesting
  As an user
  I want to be able to view a question with answers
} do
  let(:question) { create(:question) }
  let(:answers) { create_list(:answer, 10) }

  scenario 'User tries to view question with answers' do
    question.answers = answers
    answers.last.choose_the_best
    visit question_path(question)
    expect(page).to have_content question.title
    expect(page).to have_content question.body
    answers.each { |answer| expect(page).to have_content answer.body }
    expect(all('.answer').first).to have_content answers.last.body
  end
end