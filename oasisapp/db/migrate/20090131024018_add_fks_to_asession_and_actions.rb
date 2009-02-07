class AddFksToAsessionAndActions < ActiveRecord::Migration
  def self.up
  	add_column :asessions, :admin_id, :integer
  	add_column :actions, :asession_id, :integer
  	
  end

  def self.down
  	remove_column :asessions, :admin_id, :integer
  	remove_column :actions, :asession_id, :integer
  	
  end
end
