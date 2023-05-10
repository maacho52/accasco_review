class RemoveColumnsToReviews < ActiveRecord::Migration[6.1]
  def change
    remove_column :reviews, :all_rating, :float, null: false, default: 0
    remove_column :reviews, :rating1, :float, null: false, default: 0
    remove_column :reviews, :rating2, :float, null: false, default: 0
    remove_column :reviews, :rating3, :float, null: false, default: 0
    remove_column :reviews, :rating4, :float, null: false, default: 0
  end
end
