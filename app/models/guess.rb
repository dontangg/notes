class Guess < ActiveRecord::Base
  belongs_to :attempt
  belongs_to :song
  belongs_to :user

  validates_presence_of :user_id
  validates_presence_of :song_id

  attr_accessor :previously_guessed_names

  # true if a previous guess was correct
  def correct?
    @correct
  end
  def correct=(value)
    @correct = value
  end
end
