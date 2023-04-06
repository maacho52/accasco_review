class CreateArrangesTags < ActiveRecord::Migration[6.1]
  def change
    create_table :arranges_tags do |t|
      t.references :score, null: false, foreign_key: true
      t.references :arrange, null: false, foreign_key: true

      t.timestamps
    end

    # 同じタグを２回保存するのは出来ないようになる
    #add_index :arrange_tags, [:score_id, :arrange_id], unique: true
  end
end
