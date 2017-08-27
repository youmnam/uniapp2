class CreatePostlikes < ActiveRecord::Migration[5.1]
  def change
    create_table :postlikes do |t|
      t.references :user_app, foreign_key: true
      t.references :post, foreign_key: true

      t.timestamps
    end
  end
end
