class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :user
      t.string :from
      t.integer :numnotifi

      t.timestamps
    end
  end
end
