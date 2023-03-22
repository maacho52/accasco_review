class Score < ApplicationRecord
  has_many :comments
  has_many :arranges
  belongs_to :user
  belongs_to :site
  
  enum member: { three: 0, four: 1, five: 2, six: 3, seven_or_more: 4, boys: 5, girls: 6 }
  enum difficulty: { introduction: 0, biginner: 1, intermediate: 2, advanced: 3, superlative: 4 }
end
