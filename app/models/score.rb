class Score < ApplicationRecord
  has_many :reviews, dependent: :destroy
  belongs_to :user
  belongs_to :site

  has_one_attached :image

    #score_arrangesのリレーション記載
  has_many :score_arranges, dependent: :destroy
  has_many :arranges, through: :score_arranges

  enum member: { three: 0, four: 1, five: 2, six: 3, seven_or_more: 4, boys: 5, girls: 6 }
  enum difficulty: { introduction: 0, biginner: 1, intermediate: 2, advanced: 3, superlative: 4 }

  def save_arrange(arrange_ids)
    arrange_ids.each do |arrange_id|
      ScoreArrange.create(score_id: id, arrange_id: arrange_id)
    end
  end


  def self.search(search)
    if search != ""
      Score.joins(:arrange, :site).where('artist LIKE(?) OR name LIKE(?) OR site.name LIKE(?) OR arrange.body', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
    else
      Score.all
    end
  end

  def get_image(width, height)
   unless image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
   end
    image.variant(resize_to_limit: [width, height]).processed
  end

end
