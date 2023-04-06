class Score < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :arranges
  belongs_to :user
  belongs_to :site

    #arrange_tagのリレーション記載
  has_many :arrange_tags, dependent: :destroy
  has_many :arrange, through: :arrange_tags

  enum member: { three: 0, four: 1, five: 2, six: 3, seven_or_more: 4, boys: 5, girls: 6 }
  enum difficulty: { introduction: 0, biginner: 1, intermediate: 2, advanced: 3, superlative: 4 }
end
