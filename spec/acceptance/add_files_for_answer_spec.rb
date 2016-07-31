require_relative 'acceptance_helper'

feature 'User can add files for his answer', %q{
  In order to improve my explanation with an example
  As an author
  I want to be able to add files for my answer
} do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  background do
    sign_in(user)
    visit question_path(question)
  end

  scenario 'Author tries to add files for his answer', js: true do
    fill_in 'Your answer', with: 'some_answer'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Confirm'

    within '.answers' do
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end
end