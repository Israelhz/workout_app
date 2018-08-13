require 'rails_helper'

RSpec.feature 'SHowing Friend Workout' do
  before do
    @john = User.create(first_name: 'John',
                        last_name: 'Doe',
                        email: 'john@example.com',
                        password: 'password')
    
    @sarah = User.create(first_name: 'Sarah',
                        last_name: 'Anderson',
                        email: 'sarah@example.com',
                        password: 'password')

    login_as @john

    @exercise1 = @john.exercises.create(duration_in_min: 100,
                                        workout: 'My body building activity',
                                        workout_date: Date.today)
    @exercise2 = @sarah.exercises.create(duration_in_min: 110,
                                        workout: 'Weight lifting',
                                        workout_date: 2.days.ago)

    @following = Friendship.create(user: @john, friend: @sarah)
  end

  scenario "shows friend's workout for last 7 days" do
    visit '/'

    click_link 'My Lounge'
    click_link @sarah.full_name

    expect(page).to have_content "#{@sarah.full_name}'s Exercises"
    expect(page).to have_content @exercise2.workout
    expect(page).to have_css "div#chart"
  end
end