class AddColumnsToReviews < ActiveRecord::Migration[6.1]
  def change
    add_column :reviews, :all_rating, :float, null: false, default: 0
    add_column :reviews, :rating1, :float, null: false, default: 0
    add_column :reviews, :rating2, :float, null: false, default: 0
    add_column :reviews, :rating3, :float, null: false, default: 0
    add_column :reviews, :rating4, :float, null: false, default: 0
  end
end
