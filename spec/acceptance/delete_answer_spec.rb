require_relative 'acceptance_helper'

feature 'User deletes his answer.', %q{
  In order to cover my shame
  As an author of answer
  I want be able to delete my answers
} do

  let(:answer) { create(:answer) }
  let(:another_user) { create(:user) }

  scenario 'Authenticated user tries to delete his answer', js: true do
    sign_in(answer.user)

    visit question_path(answer.question)
    click_on 'Delete the answer'

    expect(current_path).to eq question_path(answer.question)
    expect(page).to_not have_content answer.body

  end

  scenario "Authenticated user tries to delete another author's answer" do
    sign_in(another_user)

    visit question_path(answer.question)

    expect(page).to_not have_content 'Delete the answer'
  end

  scenario 'Non-authenticated user tries to delete a answer' do
    visit question_path(answer.question)

    expect(page).to_not have_content 'Delete the answer'
  end
end