class ScoreArrange < ApplicationRecord
  belongs_to :score
  belongs_to :arrange
  validates :score_id, presence: true
  validates :arrange_id, presence: true
end
