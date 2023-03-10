class CreateScores < ActiveRecord::Migration[6.1]
  def change
    create_table :scores do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
      t.string :artist, null: false
      t.string :member, null: false, default: 0
      t.string :difficulty, null: false, default: 0
      t.timestamps
    end
  end
end
