class FixAnnouncements < ActiveRecord::Migration
  def self.up
		  add_column :announcements, :date_time, :timestamp, :null => false
		  add_column :announcements, :announcement, :text, :null => false
  end

  def self.down
  		add_column :announcements, :date_time
		  add_column :announcements, :announcement, :text
  end
end
