class CreateEvents < ActiveRecord::Migration
   def self.up
    create_table :events do |t|
      t.string :application_id
      t.string :name
      t.string :property_1
      t.string :property_2
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end
