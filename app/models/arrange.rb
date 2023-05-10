class Arrange < ApplicationRecord
  #belongs_to :score
  has_many :score_arranges, dependent: :destroy, foreign_key: 'arrange_id'
  has_many :scores, through: :score_arranges, validate: false
  # アレンジは複数の楽譜投稿を持つ　それは、score_arrangesを通じて参照できる
  validates :body, uniqueness: true, presence: true
end