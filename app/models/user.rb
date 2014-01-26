class User < ActiveRecord::Base
  has_many :songs, dependent: :destroy
  has_many :attempts, dependent: :destroy

  attr_accessor :password
  before_save :encrypt_password

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :name
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, with: /\A[^@\s]+@[-a-z0-9.]+\.[a-z]{2,}\z/, on: :create

  def group_attempts
    if self.group_id.present?
      group_user_ids = User.where(group_id: self.group_id).pluck(:id)
      Attempt.where(user_id:group_user_ids)
    else
      self.attempts
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(email, password)
    user = find_by(email: email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
end
