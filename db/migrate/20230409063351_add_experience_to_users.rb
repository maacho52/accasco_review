class AddExperienceToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :experience, :integer
  end
end
