class Attempt < ActiveRecord::Base
  default_scope { order created_at: :asc }

  belongs_to :user
  has_many :guesses, dependent: :destroy
  accepts_nested_attributes_for :guesses

  # validate :only_one_attempt_per_day, on: :create

  attr_accessor :correctly_guessed_names

  # This doesn't work anymore now that we're allowing people who got behind to submit multiple guesses in
  # one day to catch up with everyone else. So, we're relying on the
  #
  # def only_one_attempt_per_day
  #   prev_attempts = user.group_attempts.where(competition_id:competition_id).reject { |a| a.new_record? }
  #   already_attempted_today = prev_attempts && prev_attempts.any? && prev_attempts.last.created_at.today?

  #   disallow_attempt = already_attempted_today
  #   if already_attempted_today
  #     first_attempt = current_competition.attempts.order(:created_at).first
  #     num_guesses_allowed = (Date.today - first_attempt.created_at).ceil + 1
  #     disallow_attempt = attempt_count >= num_guesses_allowed
  #   end

  #   if disallow_attempt
  #     errors.add(:daily_attempt, "has already been submitted")
  #   end
  # end
end
