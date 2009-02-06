class AddLnameFnameMnameNicknameAddressLangCpToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :middle_name, :string
    add_column :users, :address, :string
    add_column :users, :cp_number, :string
    add_column :users, :lang_pref, :integer
    add_column :users, :nickname, :string
  end

  def self.down
     remove_column :users, :last_name
     remove_column :users, :first_name
     remove_column :users, :middle_name
     remove_column :users, :address
     remove_column :users, :cp_number
     remove_column :users, :lang_pref
     remove_column :users, :nickname
   
  end
end
