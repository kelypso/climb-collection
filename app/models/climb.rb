class Climb < ActiveRecord::Base
  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods
  
  belongs_to :user
  
  validates :name, uniqueness: { case_sensitive: false }
end