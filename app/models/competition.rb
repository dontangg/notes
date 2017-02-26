class Competition < ActiveRecord::Base
  has_many :attempts
  has_many :songs

  def submitting?
    read_attribute(:phase) == 0
  end

  def guessing?
    read_attribute(:phase) == 1
  end

  def closed?
    read_attribute(:phase) == 2
  end

  def phase_name
    case read_attribute(:phase)
    when 0
      "submitting"
    when 1
      "guessing"
    when 2
      "closed"
    end
  end
end
