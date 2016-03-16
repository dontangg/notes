class Competition < ActiveRecord::Base
  has_many :attempts
  has_many :songs

  def submitting=(val)
    write_attribute(:phase, val ? 0 : 1)
  end

  def guessing=(val)
    self.submitting=(false)
  end

  def submitting?
    read_attribute(:phase) == 0
  end

  def guessing?
    read_attribute(:phase) == 1
  end
end
