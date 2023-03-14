class AddPartToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :part, :string, default: 0, null: false
  end
end
