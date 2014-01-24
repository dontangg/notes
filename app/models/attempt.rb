class Attempt < ActiveRecord::Base
  has_many :guesses, dependent: :destroy
  accepts_nested_attributes_for :guesses
end
