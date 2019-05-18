class Climb < ActiveRecord::Base
  belongs_to :user
  
  validates :name, presence: true
  validates :location, presence: true
  validates :status, presence: true
  
  def slug
     name.downcase.split.join("-")
   end

   def self.find_by_slug(slug)
     self.all.detect {|s| s.slug == slug}
   end
   
end