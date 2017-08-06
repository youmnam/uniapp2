class ChangeFeesRangeType2 < ActiveRecord::Migration[5.1]
  def change
  	  	change_column :schools, :school_feesRange, :string
  end
end
