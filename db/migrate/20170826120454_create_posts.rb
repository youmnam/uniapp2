class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :content
      t.integer :numberOfLikes
      t.references :user_app, foreign_key: true

      t.timestamps
    end
  end
end
