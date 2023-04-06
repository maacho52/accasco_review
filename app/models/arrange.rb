class Arrange < ApplicationRecord
  belongs_to :score
  has_many :arrange_tags, dependent: :destroy, foreign_key: 'arrange_id'
  has_many :scores, through: :arrange_tags
  # タグは複数の楽譜投稿を持つ　それは、arrange_tagsを通じて参照できる
  validates :name, uniqueness: true, presence: true
end
