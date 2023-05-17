class ChangeArrangeTagsToScoreArranges < ActiveRecord::Migration[6.1]
  def change
    rename_table :arrange_tags, :score_arranges
  end
end
