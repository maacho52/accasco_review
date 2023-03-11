class ChangeCloumnsNotnullAddUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :birthday, :date, null: false
  end
end
