class FixFkActions < ActiveRecord::Migration
  def self.up
  	
  	rename_column :actions, :asession_id, :admin_id
  	
  end

  def self.down
  end
end
