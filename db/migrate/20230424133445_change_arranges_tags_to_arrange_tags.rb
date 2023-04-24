class ChangeArrangesTagsToArrangeTags < ActiveRecord::Migration[6.1]
  def change
    rename_table :arranges_tags, :arrange_tags
  end
end
