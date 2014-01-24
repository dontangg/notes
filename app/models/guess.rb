class Guess < ActiveRecord::Base
  belongs_to :attempt
  belongs_to :song

  validates_presence_of :user_id
  validates_presence_of :song_id
end
