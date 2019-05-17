class User < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  
  has_many :climbs
  
  validates :name, uniqueness: true
  validates :email, uniqueness: true
  
  has_secure_password
end