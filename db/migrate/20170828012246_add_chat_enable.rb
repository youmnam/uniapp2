class AddChatEnable < ActiveRecord::Migration[5.1]
   def change
   	add_column :schools, :chateEnable, :boolean , default: false
  end
end
