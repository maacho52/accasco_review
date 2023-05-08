class ChangeMemberAndDifficultyToInteger < ActiveRecord::Migration[6.1]
  def change
    change_column :scores, :member, :integer
    change_column :scores, :difficulty, :integer
  end
end
