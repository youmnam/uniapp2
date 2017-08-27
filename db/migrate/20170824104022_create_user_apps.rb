class CreateUserApps < ActiveRecord::Migration[5.1]
  def change
    create_table :user_apps do |t|
      t.string :name
	  t.string :email
      t.string :password_digest
      t.string :ppic

      t.timestamps
    end
  end
end
