require 'digest'

module ApplicationHelper
  # https://en.gravatar.com/site/implement/images/
  # https://en.gravatar.com/site/implement/hash/
  def gravatar_url(email, size = 80)
    hash = Digest::MD5.hexdigest(email.downcase)
    "//www.gravatar.com/avatar/#{hash}?s=#{size}"
  end
end
