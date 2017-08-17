class AddSpecialNeeds < ActiveRecord::Migration[5.1]
    def change
  		add_column :schools, :specialNeed, :boolean, default: false
  	end
end
