class Song < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name
  validates_presence_of :artist

end
