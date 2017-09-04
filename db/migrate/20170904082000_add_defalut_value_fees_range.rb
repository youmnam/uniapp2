class AddDefalutValueFeesRange < ActiveRecord::Migration[5.1]
  def change
  	   change_column :schools, :school_feesRange, :string, default: "0"
  end
end
