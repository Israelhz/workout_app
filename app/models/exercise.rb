class Exercise < ApplicationRecord
  belongs_to :user

  alias_attribute :workout_details, :workout
  alias_attribute :activity_date, :workout_date

  validates :duration_in_min, numericality: { greater_than: 0 }
  validates :workout_details, presence: true
  validates :activity_date, presence: true

  scope :in_last_seven_days, -> {
    where('workout_date >= ?', 7.days.ago).order(workout_date: :desc)
  }
end
