class RemoveScoreIdFromArranges < ActiveRecord::Migration[6.1]
  def change
    remove_column :arranges, :score_id, :string
  end
end
