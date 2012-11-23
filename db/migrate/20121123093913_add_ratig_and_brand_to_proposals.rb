class AddRatigAndBrandToProposals < ActiveRecord::Migration
  def change
    change_table :proposals do |t|
      t.remove :description
      t.remove :category
      t.remove :country

      t.string  :brand,   :limit => 50, :after => :title
      t.decimal :rating,  :precision => 8, :scale => 2, :after => :brand 
    end
  end
end
