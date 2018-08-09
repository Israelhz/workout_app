require 'rails_helper'

RSpec.feature 'Homepage' do

  before do
    visit '/'
  end

  it 'Loads the homepage content' do
    expect(page).to have_content 'Home'
    expect(page).to have_content 'Athletes Den'
    expect(page).to have_content 'Workout Lounge!'
    expect(page).to have_content 'Show off your workout!'
  end
end