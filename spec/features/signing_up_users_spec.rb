require 'rails_helper'

RSpec.feature 'Signing up users' do

  scenario 'with valid credentials' do
    visit '/'

    click_link 'Sign up'
    fill_in 'Email', with: 'john@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_button 'Sign up'

    expect(page).to have_content 'You have signed up successfully'
  end

  scenario 'with non valid credentials' do
    visit '/'

    click_link 'Sign up'
    fill_in 'Email', with: ''
    fill_in 'Password', with: ''
    fill_in 'Password confirmation', with: ''
    click_button 'Sign up'

    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"
  end
end