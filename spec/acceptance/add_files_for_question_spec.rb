require_relative 'acceptance_helper'

feature 'User can add files for his question', %q{
  In order to improve my explanation with an example
  As an author
  I want to be able to add files for my question
} do
  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'Author tries to add files for his question' do
    fill_in 'Title', with: 'some_title'
    fill_in 'Body', with: 'some_body'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Confirm'

    expect(page).to have_content 'spec_helper.rb'
  end
end