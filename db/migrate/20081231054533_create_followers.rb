class CreateFollowers < ActiveRecord::Migration
  def self.up
    create_table :followers do |t|
      t.integer :idno
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :followers
  end
end
