class CreateArranges < ActiveRecord::Migration[6.1]
  def change
    create_table :arranges do |t|
      t.integer :score_id, null: false
      t.string :body, null: false
      t.timestamps
    end
  end
end
