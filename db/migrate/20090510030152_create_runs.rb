class CreateRuns < ActiveRecord::Migration
  def self.up
    create_table :runs do |t|
      t.column :user_id, :integer, :null => false
      t.column :date, :date
      t.column :miles, :integer
      t.column :route, :string
      t.timestamps
    end

    add_index :runs, :user_id
  end

  def self.down
    drop_table :runs
  end
end
