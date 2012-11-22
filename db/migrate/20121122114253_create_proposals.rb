class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string  :title
      t.text    :description
      t.string  :category, :limit => 50
      t.string  :country, :limit => 50
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps
    end
  end
end
