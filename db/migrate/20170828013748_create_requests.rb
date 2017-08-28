class CreateRequests < ActiveRecord::Migration[5.1]
  def change
    create_table :requests do |t|
      t.references :school, foreign_key: true
   	  t.boolean :seen
      t.timestamps
    end
  end
end
