class User < ActiveRecord::Base
  has_many :climbs
  has_secure_password
end