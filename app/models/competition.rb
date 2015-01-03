class Competition < ActiveRecord::Base
  has_many :attempts
  has_many :songs
end
