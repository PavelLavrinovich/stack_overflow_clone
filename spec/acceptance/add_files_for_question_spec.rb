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

  scenario 'Author tries to add files for his question', js: true do
    fill_in 'Title', with: 'some_title'
    fill_in 'Body', with: 'some_body'
    5.times { click_on 'Add the file' }
    wait_for_ajax
    files = page.all('input[type=file]')
    files[0].set "#{Rails.root}/spec/spec_helper.rb"
    files[1].set "#{Rails.root}/spec/rails_helper.rb"
    files[2].set "#{Rails.root}/spec/support/acceptance_helper.rb"
    files[3].set "#{Rails.root}/spec/support/controller_macros.rb"
    files[4].set "#{Rails.root}/spec/support/wait_for_ajax.rb"
    click_on 'Confirm'

    expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    expect(page).to have_link 'rails_helper.rb', href: '/uploads/attachment/file/2/rails_helper.rb'
    expect(page).to have_link 'acceptance_helper.rb', href: '/uploads/attachment/file/3/acceptance_helper.rb'
    expect(page).to have_link 'controller_macros.rb', href: '/uploads/attachment/file/4/controller_macros.rb'
    expect(page).to have_link 'wait_for_ajax.rb', href: '/uploads/attachment/file/5/wait_for_ajax.rb'
  end
end