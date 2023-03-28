class Review < ApplicationRecord
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :score

  # 星の評価の空を禁止する、且つ1以上、5未満
  validates :star, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1,
  }, presence: true
end
