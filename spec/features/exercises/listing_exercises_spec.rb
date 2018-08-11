require 'rails_helper'

RSpec.feature 'Listing Exercises' do
  before do
    @john = User.create(first_name: 'John',
                        last_name: 'Doe',
                        email: 'john@example.com',
                        password: 'password')
    login_as @john

    @exercise1 = @john.exercises.create(duration_in_min: 100,
                                        workout: 'My body building activity',
                                        workout_date: Date.today)
    @exercise2 = @john.exercises.create(duration_in_min: 110,
                                        workout: 'Weight lifting',
                                        workout_date: 2.days.ago)
  
    fred = User.create(first_name: 'Fred',
                       last_name: 'Last',
                       email: 'fred@example.com',
                       password: 'password')
    @exercise3 = fred.exercises.create(duration_in_min: 120,
                                       workout: 'Push upds',
                                       workout_date: 1.day.ago)
  
    @exercise4 = @john.exercises.create(duration_in_min: 130,
                                       workout: 'Exercise 4 push ups',
                                       workout_date: 10.day.ago)
  end

  scenario "shows user's workout for last 7 days" do
    visit '/'

    click_link 'My Lounge'

    expect(page).to have_content(@exercise1.duration_in_min)
    expect(page).to have_content(@exercise1.workout)
    expect(page).to have_content(@exercise1.workout_date)

    expect(page).to have_content(@exercise2.duration_in_min)
    expect(page).to have_content(@exercise2.workout)
    expect(page).to have_content(@exercise2.workout_date)

    expect(page).not_to have_content(@exercise3.duration_in_min)
    expect(page).not_to have_content(@exercise3.workout)
    expect(page).not_to have_content(@exercise3.workout_date)

    expect(page).not_to have_content(@exercise4.duration_in_min)
    expect(page).not_to have_content(@exercise4.workout)
    expect(page).not_to have_content(@exercise4.workout_date)
   end

  scenario "shows no exercises if none created" do
    @john.exercises.delete_all
    visit '/'

    click_link 'My Lounge'
    expect(page).to have_content 'No Workouts Yet'
  end
end