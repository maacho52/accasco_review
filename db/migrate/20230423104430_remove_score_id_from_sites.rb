class RemoveScoreIdFromSites < ActiveRecord::Migration[6.1]
  def change
    remove_column :sites, :score_id, :string
  end
end
