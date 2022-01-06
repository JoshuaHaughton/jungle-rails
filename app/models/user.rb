class User < ActiveRecord::Base
  has_secure_password

  def name
    "#{username} - #{email}"
  end
end
