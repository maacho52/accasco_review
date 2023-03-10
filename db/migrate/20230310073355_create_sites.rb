class CreateSites < ActiveRecord::Migration[6.1]
  def change
    create_table :sites do |t|
      t.integer :score_id, null: false
      t.string :name, null: false
      t.timestamps
    end
  end
end
