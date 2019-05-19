class CreateClimbsTable < ActiveRecord::Migration
  def change
    create_table :climbs do |c| 
      c.string :name 
      c.string :grade 
      c.string :location 
      c.string :category 
      c.string :status 
      c.text :notes 
      c.integer :user_id
    end
  end
end