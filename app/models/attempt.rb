class Attempt < ActiveRecord::Base
  default_scope { order created_at: :asc }

  belongs_to :user
  has_many :guesses, dependent: :destroy
  accepts_nested_attributes_for :guesses

  validate :only_one_attempt_per_day, on: :create

  attr_accessor :correctly_guessed_names

  def only_one_attempt_per_day
    prev_attempts = user.group_attempts.where(competition_id:competition_id).reject { |a| a.new_record? }
    already_attempted_today = prev_attempts && prev_attempts.any? && prev_attempts.last.created_at.today?
    if already_attempted_today
      errors.add(:daily_attempt, "has already been submitted")
    end
  end
end
