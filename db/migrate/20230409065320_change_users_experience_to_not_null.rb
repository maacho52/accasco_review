class ChangeUsersExperienceToNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :experience, false
  end
end
