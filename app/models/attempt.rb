class Attempt < ActiveRecord::Base
  default_scope { order created_at: :asc }

  belongs_to :user
  has_many :guesses, dependent: :destroy
  accepts_nested_attributes_for :guesses
end
