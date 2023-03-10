class Score < ApplicationRecord
  has_many :comments
  has_many :arranges
  belongs_to :user
  belongs_to :site
end
