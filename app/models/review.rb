class Review < ApplicationRecord
  has_many :comments
  belongs_to :user
  belongs_to :score
end
