class AddSiteIdToScores < ActiveRecord::Migration[6.1]
  def change
    add_column :scores, :site_id, :integer, null: false
  end
end
