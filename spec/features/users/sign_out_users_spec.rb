require 'rails_helper'

RSpec.feature 'Signing out users' do

  before do
    @john = User.create(first_name: 'John',
                        last_name: 'Doe',
                        email: 'john@example.com',
                        password: 'password')
    login_as @john
  end

  scenario do
    visit '/'

    click_link 'Sign out'

    expect(page).to have_content 'Signed out successfully'
    expect(page).not_to have_content 'Sign out'
  end
end