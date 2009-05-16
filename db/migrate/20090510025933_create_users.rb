class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :username, :string, :null => false
      t.column :name, :string, :null => false
      t.column :password, :string
      t.column :email, :string
      t.column :fb_uid, :integer, :default => 0
      t.column :email_hash, :string, :limit => 64, :null => true
      t.timestamps
    end
    add_index :users, :username
  end

  def self.down
    drop_table :users
  end
end
