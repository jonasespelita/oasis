class AddFksToAsessionAndActions < ActiveRecord::Migration
  def self.up
  	add_column :asessions, :admin_id, :integer
  	add_column :actions, :asession_id, :integer
  	execute "ALTER TABLE asessions ADD CONSTRAINT fk_asessions_to_admin FOREIGN KEY (admin_id) REFERENCES admins (id);"
  	execute "ALTER TABLE actions ADD CONSTRAINT fk_actions_to_asessions FOREIGN KEY (asession_id) REFERENCES asessions (id);"
  end

  def self.down
  	remove_column :asessions, :admin_id, :integer
  	remove_column :actions, :asession_id, :integer
  	execute "ALTER TABLE asessions DROP CONSTRAINT fk_asessions_to_admin;"
  	execute "ALTER TABLE actions DROP CONSTRAINT fk_actions_to_asessions;"
  end
end
